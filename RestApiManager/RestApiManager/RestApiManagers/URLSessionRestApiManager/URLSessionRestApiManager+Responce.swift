//
//  URLSessionRestApiManager+Responce.swift
//  RestApiManager
//
//  Created by Panevnyk Vlad on 11/1/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import Foundation

// MARK: - Transform responce type
extension URLSessionRestApiManager {
    func transformResponseType<T: Associated, ET: RestApiError>(fromResult result: ResultWithET<T, ET>) -> Result<T> {
        switch result {
        case .success(let obj):
            return .success(obj)
        case .failure(let error):
            return .failure(error)
        }
    }
}

// MARK: - Transform data to Results
extension URLSessionRestApiManager {
    func transformResponseType(fromData data: Data) -> Result<String> {
        if let value = String(data: data, encoding: .utf8) {
            return .success(value)
        } else {
            return .failure(E.unknown)
        }
    }
    
    func transformResponseType<ET: RestApiError>(fromData data: Data) -> ResultWithET<String, ET> {
        if let value = String(data: data, encoding: .utf8) {
            return .success(value)
        } else {
            return .failure(ET.unknown)
        }
    }
}

// MARK: - Decode
extension URLSessionRestApiManager {
    func decode<T: Associated, ET: RestApiError>(data: Data,
                                                 keyPath: String?,
                                                 completion: @escaping (_ result: ResultWithET<T, ET>) -> Void) {
        do {
            let object = try urlSessionRestApiManagerDIContainer
                .jsonDecoder
                .decode(T.self, from: data, keyPath: keyPath)
            completion(.success(object))
        } catch let error {
            completion(.failure(ET.init(error: error)))
        }
    }
}

// MARK: - Handle Response
extension URLSessionRestApiManager {
    func handleResponse<T, ET: RestApiError>(data: Data?,
                                             error: Error?,
                                             completion: @escaping (_ result: ResultWithET<T, ET>) -> Void,
                                             completionHandler: @escaping (Data) -> Swift.Void) {
        
        /// Handle custom error
        if let error = ET.handle(error: error, data: data) {
            completion(.failure(error))
        }
            /// Handle Error
        else if let error = error {
            completion(.failure(ET.init(error: error)))
        }
            /// Handle Data
        else if let data = data {
            completionHandler(data)
        }
            /// Handle unknown result
        else {
            completion(.failure(ET.unknown))
        }
    }
    
    //    // FIXME: - FIXME TEST CODE
    //    class Rest: RestApiMethod {
    //        var data: RestApiData
    //
    //        init(){
    //            data = RestApiData(url: "", httpMethod: .get)
    //        }
    //    }
    //
    //    class Simple: Decodable {}
    
    func handleCustomSerializerResponse<T: ResponseSerializer>(data: Data?,
                                                               error: Error?,
                                                               responseSerializer: T,
                                                               completionHandler: @escaping (Data) -> Swift.Void) {
        
        //        let fabric = URLSessionRestApiManagerDIContainer(errorType: DefaultRestApiError.self, printRequestInfo: false)
        //        let restApiManager: RestApiManager = URLSessionRestApiManager<DefaultRestApiError>(urlSessionRestApiManagerDIContainer: fabric)
        //        restApiManager.call(method: Rest()) { (res: ResultWithET<Simple, DefaultRestApiError>) in
        //
        //        }
        
        /// Handle custom error
        if let error = E.handle(error: error, data: data) {
            responseSerializer.completion(.failure(error))
        }
            /// Handle Error
        else if let error = error {
            responseSerializer.completion(.failure(E.init(error: error)))
        }
            /// Handle Data
        else if let data = data {
            completionHandler(data)
        }
            /// Handle unknown result
        else {
            responseSerializer.completion(.failure(E.unknown))
        }
    }
}
