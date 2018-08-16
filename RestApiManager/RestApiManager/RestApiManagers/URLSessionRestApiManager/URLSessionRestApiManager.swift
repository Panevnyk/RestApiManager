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
open class URLSessionRestApiManager: RestApiManager {

    /// Current URLSessionTask
    public var currentURLSessionTasks: [URLSessionTask] = []
    
    // ---------------------------------------------------------------------
    // MARK: - Simple requests
    // ---------------------------------------------------------------------
    
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
        return createDataTask(method: method, completion: completion) { [unowned self] (data) in
            if let value = String(data: data, encoding: .utf8) {
                completion(.success(value))
            } else {
                completion(.failure(self.errorType.unknown))
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
    
    // ---------------------------------------------------------------------
    // MARK: - Multipart
    // ---------------------------------------------------------------------
    
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
        return createMultipartDataTask(multipartData: multipartData, method: method, completion: completion) { [unowned self] (data) in
            if let value = String(data: data, encoding: .utf8) {
                completion(.success(value))
            } else {
                completion(.failure(self.errorType.unknown))
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
    
    /// Init
    public init() {}
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
            completionHandler(nil, nil, self.errorType.unknown)
            return nil
        }
        
        let dataTask = urlSession.dataTask(with: request) { [unowned self] (data, urlResponse, error) in
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
            completionHandler(nil, nil, self.errorType.unknown)
            return nil
        }
        
        let dataTask = urlSession.uploadTask(with: request, from: multipartData.data) { [unowned self] (data, urlResponse, error) in
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
            let object = try jsonDecoder.decode(T.self, from: data, keyPath: keyPath)
            completion(.success(object))
        } catch let error {
            completion(.failure(errorType.init(error: error)))
        }
    }
    
    func handleResponse<T>(data: Data?,
                           error: Error?,
                           completion: @escaping (_ result: Result<T>) -> Void,
                           completionHandler: @escaping (Data) -> Swift.Void) {
        
        /// Handle custom error
        if let error = errorType.handle(error: error, data: data) {
            completion(.failure(error))
        }
        /// Handle Error
        else if let error = error {
            completion(.failure(errorType.init(error: error)))
        }
        /// Handle Data
        else if let data = data {
            completionHandler(data)
        }
        /// Handle unknown result
        else {
            completion(.failure(errorType.unknown))
        }
    }
    
    func handleCustomSerializerResponse<T: ResponseSerializer>(data: Data?,
                                                               error: Error?,
                                                               responseSerializer: T,
                                                               completionHandler: @escaping (Data) -> Swift.Void) {
        
        /// Handle custom error
        if let error = errorType.handle(error: error, data: data) {
            responseSerializer.completion(.failure(error))
        }
        /// Handle Error
        else if let error = error {
            responseSerializer.completion(.failure(errorType.init(error: error)))
        }
        /// Handle Data
        else if let data = data {
            completionHandler(data)
        }
        /// Handle unknown result
        else {
            responseSerializer.completion(.failure(errorType.unknown))
        }
    }
}
