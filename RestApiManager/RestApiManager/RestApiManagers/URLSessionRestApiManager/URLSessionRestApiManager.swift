//
//  URLSessionRestApiManager.swift
//  Roadwarez
//
//  Created by Panevnyk Vlad on 10/6/17.
//  Copyright © 2017 Roadwarez. All rights reserved.
//

import Foundation

// MARK: - Associated = Codable
public typealias Associated = Codable

// MARK: - URLSessionRestApiManager
open class URLSessionRestApiManager: RestApiManager {

    // ---------------------------------------------------------------------
    // MARK: - Simple requests
    // ---------------------------------------------------------------------
    
    /// Object call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: Result<T>
    public func call<T: Associated>(method: RestApiMethod, completion: @escaping (_ result: Result<T>) -> Void) {
        createDataTask(method: method, completion: completion)
    }
    
    /// Array call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: Result<[T]>
    public func call<T: Associated>(method: RestApiMethod, completion: @escaping (_ result: Result<[T]>) -> Void) {
        createDataTask(method: method, completion: completion)
    }
    
    /// String call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: Result<String>
    public func call(method: RestApiMethod, completion: @escaping (_ result: Result<String>) -> Void) {
        createDataTask(method: method, completion: completion) { (data) in
            if let answer = String(data: data, encoding: .utf8) {
                completion(.success(answer))
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
    public func call<T: ResponseSerializer>(method: RestApiMethod, responseSerializer: T) {
        createDataTask(method: method) { (data, urlResponse, error) in
            responseSerializer.parse(method: method, response: urlResponse as? HTTPURLResponse, data: data, error: error)
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
    public func call<T: Associated>(multipartData: MultipartData,
                                    method: RestApiMethod,
                                    completion: @escaping (_ result: Result<T>) -> Void) {
        guard let request = request(method: method) else {
            completion(.failure(errorType.unknown))
            return
        }
        
        URLSession.shared.uploadTask(with: request, from: multipartData.data) { (data, _, error) in
            self.handleResponse(data: data, error: error, completion: completion, completionHandler: { (data) in
                self.decode(data: data, keyPath: method.data.keyPath, completion: completion)
            })
        }.resume()
    }
    
    /// Multipart Array call
    ///
    /// - Parameters:
    ///   - multipartData: MultipartData
    ///   - method: RestApiMethod
    ///   - completion: Result<[T]>
    public func call<T: Associated>(multipartData: MultipartData,
                                    method: RestApiMethod,
                                    completion: @escaping (_ result: Result<[T]>) -> Void) {
        guard let request = request(method: method) else {
            completion(.failure(errorType.unknown))
            return
        }
        
        URLSession.shared.uploadTask(with: request, from: multipartData.data) { (data, _, error) in
            self.handleResponse(data: data, error: error, completion: completion, completionHandler: { (data) in
                self.decode(data: data, keyPath: method.data.keyPath, completion: completion)
            })
        }.resume()
    }

    /// Multipart String call
    ///
    /// - Parameters:
    ///   - multipartData: MultipartData
    ///   - method: RestApiMethod
    ///   - completion: Result<String>
    public func call(multipartData: MultipartData,
                     method: RestApiMethod,
                     completion: @escaping (_ result: Result<String>) -> Void) {
        guard let request = request(method: method) else {
            completion(.failure(errorType.unknown))
            return
        }
        
        URLSession.shared.uploadTask(with: request, from: multipartData.data) { (data, _, error) in
            self.handleResponse(data: data, error: error, completion: completion, completionHandler: { (data) in
                if let answer = String(data: data, encoding: .utf8) {
                    completion(.success(answer))
                } else {
                    completion(.failure(self.errorType.unknown))
                }
            })
        }.resume()
    }

    /// Multipart Custom response serializer call
    ///
    /// - Parameters:
    ///   - multipartData: MultipartData
    ///   - method: RestApiMethod
    ///   - responseSerializer: T where T: ResponseSerializer
    public func call<T: ResponseSerializer>(multipartData: MultipartData,
                                            method: RestApiMethod,
                                            responseSerializer: T) {
        guard let request = request(method: method) else {
            responseSerializer.completion(.failure(errorType.unknown))
            return
        }
        
        URLSession.shared.uploadTask(with: request, from: multipartData.data) { (data, urlResponse, error) in
            self.handleResponse(data: data, error: error, completion: responseSerializer.completion, completionHandler: { (data) in
                responseSerializer.parse(method: method, response: urlResponse as? HTTPURLResponse, data: data, error: error)
            })
        }.resume()
    }
    
    /// Deinit
    deinit {
        print(" --- URLSessionRestApiManager deinit --- ")
    }
}

// MARK: - DataTask
private extension URLSessionRestApiManager {
    func createDataTask<T: Associated>(method: RestApiMethod,
                                       completion: @escaping (_ result: Result<T>) -> Void) {
        createDataTask(method: method, completion: completion) { (data) in
            self.decode(data: data, keyPath: method.data.keyPath, completion: completion)
        }
    }
    
    func createDataTask<T>(method: RestApiMethod,
                           completion: @escaping (_ result: Result<T>) -> Void,
                           completionHandler: @escaping (Data) -> Swift.Void) {
        createDataTask(method: method) { (data, _, error) in
            self.handleResponse(data: data, error: error, completion: completion, completionHandler: completionHandler)
        }
    }
    
    func createDataTask(method: RestApiMethod,
                        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        guard let request = request(method: method) else {
            completionHandler(nil, nil, self.errorType.unknown)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            /// Print response
            self.printDataResponse(urlResponse, request: request, data: data)
            /// Completion Handler
            completionHandler(data, urlResponse, error)
        }
        dataTask.resume()
    }
}

// MARK: - Handle Response
private extension URLSessionRestApiManager {
    func decode<T: Associated>(data: Data,
                               keyPath: String?,
                               completion: @escaping (_ result: Result<T>) -> Void) {
        do {
            let object = try JSONDecoder().decode(T.self, from: data, keyPath: keyPath)
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
        /// Hadle Error
        else if let error = error {
            completion(.failure(errorType.init(error: error)))
        }
        /// Hadle Data
        else if let data = data {
            completionHandler(data)
        }
        /// Hadle unknown result
        else {
            completion(.failure(errorType.unknown))
        }
    }
}
