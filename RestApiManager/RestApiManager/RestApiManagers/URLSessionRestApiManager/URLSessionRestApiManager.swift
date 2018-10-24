//
//  URLSessionRestApiManager.swift
//  Roadwarez
//
//  Created by Panevnyk Vlad on 10/6/17.
//  Copyright © 2017 Roadwarez. All rights reserved.
//

import Foundation

// MARK: - Associated = Decodable
public typealias Associated = Decodable

// MARK: - URLSessionRestApiManager
open class URLSessionRestApiManager<E>: RestApiManager where E: RestApiError {

    // ---------------------------------------------------------------------
    // MARK: - Properties
    // ---------------------------------------------------------------------
    
    /// RestApiManagerDIFabric
    public var restApiManagerDIFabric: RestApiManagerDIFabric {
        return urlSessionRestApiManagerDIFabric
    }
    
    /// URLSessionRestApiManagerDIFabric
    let urlSessionRestApiManagerDIFabric: URLSessionRestApiManagerDIFabric<E>
    
    /// Current URLSessionTask
    public var currentURLSessionTasks: [URLSessionTask] = []
    
    // ---------------------------------------------------------------------
    // MARK: - Inits
    // ---------------------------------------------------------------------
    
    /// Init with URLSessionRestApiManager properties
    ///
    /// - Parameter urlSessionRestApiManagerDIFabric: URLSessionRestApiManagerDIFabric
    public init(urlSessionRestApiManagerDIFabric: URLSessionRestApiManagerDIFabric<E>) {
        self.urlSessionRestApiManagerDIFabric = urlSessionRestApiManagerDIFabric
    }
    
    /// Init with default URLSessionRestApiManager properties
    public init() {
        urlSessionRestApiManagerDIFabric =
            URLSessionRestApiManagerDIFabric(errorType: DefaultRestApiError.self) as! URLSessionRestApiManagerDIFabric<E>
    }
}

// MARK: - Simple requests
extension URLSessionRestApiManager {
    /// Object call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: Result<T>
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call<T: Associated>(method: RestApiMethod, completion: @escaping (_ result: Result<T>) -> Void) -> URLSessionTask? {
        return createDataTask(method: method, completion: completion)
    }
    
    /// Array call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: Result<[T]>
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call<T: Associated>(method: RestApiMethod, completion: @escaping (_ result: Result<[T]>) -> Void) -> URLSessionTask? {
        return createDataTask(method: method, completion: completion)
    }
    
    /// String call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: Result<String>
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call(method: RestApiMethod, completion: @escaping (_ result: Result<String>) -> Void) -> URLSessionTask? {
        return createDataTask(method: method, completion: completion) { (data) in
            if let value = String(data: data, encoding: .utf8) {
                completion(.success(value))
            } else {
                completion(.failure(E.unknown))
            }
        }
    }
    
    /// Custom response serializer call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - responseSerializer: T where T: ResponseSerializer
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call<T: ResponseSerializer>(method: RestApiMethod, responseSerializer: T) -> URLSessionTask? {
        return createDataTask(method: method) { (data, urlResponse, error) in
            self.handleCustomSerializerResponse(data: data, error: error, responseSerializer: responseSerializer, completionHandler: { (resData) in
                responseSerializer.parse(method: method, response: urlResponse as? HTTPURLResponse, data: resData, error: error)
            })
        }
    }
}

// MARK: - Multipart
extension URLSessionRestApiManager {
    /// Multipart Object call
    ///
    /// - Parameters:
    ///   - multipartData: MultipartData
    ///   - method: RestApiMethod
    ///   - completion: Result<T>
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call<T: Associated>(multipartData: MultipartData,
                                    method: RestApiMethod,
                                    completion: @escaping (_ result: Result<T>) -> Void) -> URLSessionTask? {
        return createMultipartDataTask(multipartData: multipartData, method: method, completion: completion)
    }
    
    /// Multipart Array call
    ///
    /// - Parameters:
    ///   - multipartData: MultipartData
    ///   - method: RestApiMethod
    ///   - completion: Result<[T]>
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call<T: Associated>(multipartData: MultipartData,
                                    method: RestApiMethod,
                                    completion: @escaping (_ result: Result<[T]>) -> Void) -> URLSessionTask? {
        return createMultipartDataTask(multipartData: multipartData, method: method, completion: completion)
    }

    /// Multipart String call
    ///
    /// - Parameters:
    ///   - multipartData: MultipartData
    ///   - method: RestApiMethod
    ///   - completion: Result<String>
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call(multipartData: MultipartData,
                     method: RestApiMethod,
                     completion: @escaping (_ result: Result<String>) -> Void) -> URLSessionTask? {
        return createMultipartDataTask(multipartData: multipartData, method: method, completion: completion) { (data) in
            if let value = String(data: data, encoding: .utf8) {
                completion(.success(value))
            } else {
                completion(.failure(E.unknown))
            }
        }
    }

    /// Multipart Custom response serializer call
    ///
    /// - Parameters:
    ///   - multipartData: MultipartData
    ///   - method: RestApiMethod
    ///   - responseSerializer: T where T: ResponseSerializer
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call<T: ResponseSerializer>(multipartData: MultipartData,
                                            method: RestApiMethod,
                                            responseSerializer: T) -> URLSessionTask? {
        return createMultipartDataTask(multipartData: multipartData, method: method) { (data, urlResponse, error) in
            self.handleCustomSerializerResponse(data: data, error: error, responseSerializer: responseSerializer, completionHandler: { (resData) in
                responseSerializer.parse(method: method, response: urlResponse as? HTTPURLResponse, data: resData, error: error)
            })
        }
    }
}

// MARK: - DataTask
private extension URLSessionRestApiManager {
    func createDataTask<T: Associated>(method: RestApiMethod,
                                       completion: @escaping (_ result: Result<T>) -> Void) -> URLSessionTask? {
        return createDataTask(method: method, completion: completion) { [unowned self] (data) in
            self.decode(data: data, keyPath: method.data.keyPath, completion: completion)
        }
    }
    
    func createDataTask<T>(method: RestApiMethod,
                           completion: @escaping (_ result: Result<T>) -> Void,
                           completionHandler: @escaping (Data) -> Swift.Void) -> URLSessionTask? {
        return createDataTask(method: method) { [unowned self] (data, _, error) in
            self.handleResponse(data: data, error: error, completion: completion, completionHandler: completionHandler)
        }
    }
    
    func createDataTask(method: RestApiMethod,
                        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionTask? {
        guard let request = request(method: method) else {
            completionHandler(nil, nil, E.unknown)
            return nil
        }
        
        let dataTask = urlSessionRestApiManagerDIFabric
            .urlSession
            .dataTask(with: request) { [unowned self] (data, urlResponse, error) in
                
            /// Print response
            self.printDataResponse(urlResponse, request: request, data: data)
            
            /// Completion Handler
            completionHandler(data, urlResponse, error)
            
            /// clearURLSessionTask
            self.clearURLSessionTask()
        }
        dataTask.resume()
        
        appendURLSessionTask(dataTask)
        
        return dataTask
    }
}

// MARK: - MultipartDataTask
private extension URLSessionRestApiManager {
    func createMultipartDataTask<T: Associated>(multipartData: MultipartData,
                                                method: RestApiMethod,
                                                completion: @escaping (_ result: Result<T>) -> Void) -> URLSessionTask? {
        return createMultipartDataTask(multipartData: multipartData, method: method, completion: completion) { [unowned self] (data) in
            self.decode(data: data, keyPath: method.data.keyPath, completion: completion)
        }
    }
    
    func createMultipartDataTask<T>(multipartData: MultipartData,
                                    method: RestApiMethod,
                                    completion: @escaping (_ result: Result<T>) -> Void,
                                    completionHandler: @escaping (Data) -> Swift.Void) -> URLSessionTask? {
        return createMultipartDataTask(multipartData: multipartData, method: method) { [unowned self] (data, _, error) in
            self.handleResponse(data: data, error: error, completion: completion, completionHandler: completionHandler)
        }
    }
    
    func createMultipartDataTask(multipartData: MultipartData,
                                 method: RestApiMethod,
                                 completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionTask? {
        guard let request = request(method: method) else {
            completionHandler(nil, nil, E.unknown)
            return nil
        }
        
        let dataTask = urlSessionRestApiManagerDIFabric
            .urlSession
            .uploadTask(with: request, from: multipartData.data) { [unowned self] (data, urlResponse, error) in
                
            /// Print response
            self.printDataResponse(urlResponse, request: request, data: data)
            
            /// Completion Handler
            completionHandler(data, urlResponse, error)
            
            /// clearURLSessionTask
            self.clearURLSessionTask()
        }
        dataTask.resume()
        
        appendURLSessionTask(dataTask)
        
        return dataTask
    }
}

// MARK: - Work URLSessionTask
private extension URLSessionRestApiManager {
    func appendURLSessionTask(_ dataTask: URLSessionTask) {
        currentURLSessionTasks.append(dataTask)
    }
    
    func clearURLSessionTask() {
        var offset = 0
        for (index, currentDataTask) in currentURLSessionTasks.enumerated() {
            if currentDataTask.state == .canceling || currentDataTask.state == .completed {
                currentURLSessionTasks.remove(at: index - offset)
                offset += 1
            }
        }
    }
}

// MARK: - Handle Response
private extension URLSessionRestApiManager {
    func decode<T: Associated>(data: Data,
                               keyPath: String?,
                               completion: @escaping (_ result: Result<T>) -> Void) {
        do {
            let object = try urlSessionRestApiManagerDIFabric
                .jsonDecoder
                .decode(T.self, from: data, keyPath: keyPath)
            completion(.success(object))
        } catch let error {
            completion(.failure(E.init(error: error)))
        }
    }
    
    func handleResponse<T>(data: Data?,
                           error: Error?,
                           completion: @escaping (_ result: Result<T>) -> Void,
                           completionHandler: @escaping (Data) -> Swift.Void) {
        
        /// Handle custom error
        if let error = E.handle(error: error, data: data) {
            completion(.failure(error))
        }
        /// Handle Error
        else if let error = error {
            completion(.failure(E.init(error: error)))
        }
        /// Handle Data
        else if let data = data {
            completionHandler(data)
        }
        /// Handle unknown result
        else {
            completion(.failure(E.unknown))
        }
    }
    
    // FIXME: - FIXME TEST CODE
    class Rest: RestApiMethod {
        var data: RestApiData
        
        init(){
            data = RestApiData(url: "", httpMethod: .get)
        }
    }
    
    func handleCustomSerializerResponse<T: ResponseSerializer>(data: Data?,
                                                               error: Error?,
                                                               responseSerializer: T,
                                                               completionHandler: @escaping (Data) -> Swift.Void) {
        
        let fabric = URLSessionRestApiManagerDIFabric(errorType: DefaultRestApiError.self, printRequestInfo: false)
        let restApiManager: RestApiManager = URLSessionRestApiManager<DefaultRestApiError>(urlSessionRestApiManagerDIFabric: fabric)
        restApiManager.call(method: Rest()) { (result: Result<String>) in
            
        }
        
        
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
