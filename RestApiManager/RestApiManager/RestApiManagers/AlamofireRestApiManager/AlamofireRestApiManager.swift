//
//  AlamofireRestApiManager.swift
//  Roadwarez
//
//  Created by Panevnyk Vlad on 10/6/17.
//  Copyright © 2017 Roadwarez. All rights reserved.
//
/*
import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

/// Associated
public typealias Associated = Mappable

/// AlamofireRestApiManager
open class AlamofireRestApiManager: RestApiManager {

    private let queue = OperationQueue()
    
    /// Object call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: Result<T>
    public func call<T: Associated>(method: RestApiMethod, completion: @escaping (Result<T>) -> Void) {
        let dataRequestValue = dataRequest(method: method)
        dataRequestValue.responseObject(queue: nil,
                                        keyPath: method.data.keyPath,
                                        mapToObject: nil,
                                        context: nil) { [unowned self] (response: DataResponse<T>) in
                                            self.dataResponse(response: response, completion: completion)
        }
    }
    
    /// Array call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: Result<[T]>
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: Result<T>
    public func call<T: Associated>(method: RestApiMethod, completion: @escaping (Result<[T]>) -> Void) {
        let dataRequestValue = dataRequest(method: method)
        dataRequestValue.responseArray(queue: nil,
                                       keyPath: method.data.keyPath,
                                       context: nil) { [unowned self] (response: DataResponse<[T]>) in
                                        self.dataResponse(response: response, completion: completion)
        }
    }
    
     /// Multipart call
     ///
     /// - Parameters:
     ///   - multipartData: MultipartData
     ///   - method: RestApiMethod
     ///   - completion: Result<T>
     public func call<T: Associated>(multipartData: MultipartData,
                                     method: RestApiMethod,
                                     completion: @escaping (_ result: Result<T>) -> Void) {
        Alamofire.upload(multipartFormData: { (data) in
            data.append(multipartData.data,
                        withName: multipartData.name,
                        fileName: multipartData.fileName,
                        mimeType: multipartData.mimeType)
        },
                         to: method.data.url,
                         method: HTTPMethod(rawValue: method.data.httpMethod.rawValue) ?? .post,
                         headers: method.data.headers,
                         encodingCompletion: { (response) in
                            switch response {
                            case .success(request: let request,
                                          streamingFromDisk: _,
                                          streamFileURL: _):
                                request.responseObject(queue: nil,
                                                       keyPath: method.data.keyPath,
                                                       mapToObject: nil,
                                                       context: nil) { [unowned self] (response: DataResponse<T>) in
                                                        self.dataResponse(response: response,
                                                                          completion: completion)
                                }
                            case .failure(let error):
                                completion(.failure(self.errorType.init(error: error)))
                            }
        })
    }
    
    /// Custom response serializer call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - responseSerializer: T where T: ResponseSerializer
    public func call<T: ResponseSerializer>(method: RestApiMethod, responseSerializer: T) {
        let dataRequestValue = dataRequest(method: method)
        dataRequestValue.responseString { (response: DataResponse<String>) in
            responseSerializer.parse(method: method, response: response.response, data: response.data, error: response.error)
        }
    }
    
    /// String call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: Result<String>
    public func call(method: RestApiMethod, completion: @escaping (_ result: Result<String>) -> Void) {
        let dataRequestValue = dataRequest(method: method)
        dataRequestValue.responseString { [unowned self] (response: DataResponse<String>) in
            self.dataResponse(response: response, completion: completion)
        }
    }
    
}

// MARK: - Create request
extension AlamofireRestApiManager {
    private func dataRequest(method: RestApiMethod) -> DataRequest {
        guard let request = request(method: method) else {
            fatalError("Alamofire dataRequest fatal error")
        }
        return Alamofire.request(request).validate(contentType: ["application/json"]).validate(statusCode: 200..<300)
    }
}

// MARK: - Response helper methods
extension AlamofireRestApiManager {
    
    // Handle data responce
    private func dataResponse<T>(response: DataResponse<T>, completion: @escaping (_ result: Result<T>) -> Void) {
        // Print responce
        printDataResponse(response.response, request: response.request, data: response.data)
        // Return result
        switch response.result {
        case .success(let value):
            if let error = errorType.handle(error: nil, data: response.data) {
                completion(.failure(error))
            } else {
                completion(.success(value))
            }
        case .failure(let error):
            if let error = errorType.handle(error: error, data: nil) {
                completion(.failure(error))
            } else {
                completion(.failure(errorType.init(error: error)))
                //                let restError = handleError(error, dataResponse: response)
                //            switch restError.code {
                //            case 0, 1, 2:
                //                queue.cancelAllOperations()
                //                UIApplication.expiredTokenAction(byError: restError)
                //            default:
                //                completion(.failure(restError))
                //            }
            }
        }
        
    }
}
*/
