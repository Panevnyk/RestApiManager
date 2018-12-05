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
    
    /// RestApiManagerDIContainer
    public var restApiManagerDIContainer: RestApiManagerDIContainer {
        return urlSessionRAMDIContainer
    }
    
    /// URLSessionRAMDIContainer
    let urlSessionRAMDIContainer: URLSessionRAMDIContainer<E>
    
    /// Current URLSessionTask
    public var currentURLSessionTasks: [URLSessionTask] = []
    
    // ---------------------------------------------------------------------
    // MARK: - Inits
    // ---------------------------------------------------------------------
    
    /// Init with URLSessionRestApiManager properties
    ///
    /// - Parameter urlSessionRAMDIContainer: URLSessionRAMDIContainer
    public init(urlSessionRAMDIContainer: URLSessionRAMDIContainer<E>) {
        self.urlSessionRAMDIContainer = urlSessionRAMDIContainer
    }
    
    /// Init with default URLSessionRestApiManager properties
    public init() {
        urlSessionRAMDIContainer =
            URLSessionRAMDIContainer(errorType: DefaultRestApiError.self) as! URLSessionRAMDIContainer<E>
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
        return call(method: method) { (result: ResultWithET<T, E>) in
            completion(self.transformResponseType(fromResult: result))
        }
    }
    
    /// Array call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: Result<[T]>
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call<T: Associated>(method: RestApiMethod, completion: @escaping (_ result: Result<[T]>) -> Void) -> URLSessionTask? {
        return call(method: method) { (result: ResultWithET<[T], E>) in
            completion(self.transformResponseType(fromResult: result))
        }
    }
    
    /// String call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: Result<String>
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call(method: RestApiMethod, completion: @escaping (_ result: Result<String>) -> Void) -> URLSessionTask? {
        return call(method: method) { (result: ResultWithET<String, E>) in
            completion(self.transformResponseType(fromResult: result))
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
        return createDataTaskWithET(method: method, errorType: E.self) { (data, urlResponse, error) in
            self.handleCustomSerializerResponse(data: data, urlResponse: urlResponse, error: error, responseSerializer: responseSerializer, completionHandler: { (resData) in
                responseSerializer.parse(method: method, response: urlResponse as? HTTPURLResponse, data: resData, error: error)
            })
        }
    }
}

// MARK: - Simple requests with ET
extension URLSessionRestApiManager {
    /// Object call with ET
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: ResultWithET<T, ET>
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call<T: Associated, ET: RestApiError>(method: RestApiMethod, completion: @escaping (_ result: ResultWithET<T, ET>) -> Void) -> URLSessionTask? {
        return createDataTaskWithET(method: method, completion: completion)
    }
    
    /// Array call with ET
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: ResultWithET<[T], ET>
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call<T: Associated, ET: RestApiError>(method: RestApiMethod, completion: @escaping (_ result: ResultWithET<[T], ET>) -> Void) -> URLSessionTask? {
        return createDataTaskWithET(method: method, completion: completion)
    }
    
    /// String call with ET
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: ResultWithET<String, ET>
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call<ET: RestApiError>(method: RestApiMethod, completion: @escaping (_ result: ResultWithET<String, ET>) -> Void) -> URLSessionTask? {
        return createDataTaskWithET(method: method, completion: completion) { [unowned self] (data) in
            completion(self.transformResponseType(fromData: data))
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
        return call(multipartData: multipartData, method: method) { (result: ResultWithET<T, E>) in
            completion(self.transformResponseType(fromResult: result))
        }
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
        return call(multipartData: multipartData, method: method) { (result: ResultWithET<[T], E>) in
            completion(self.transformResponseType(fromResult: result))
        }
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
        return call(multipartData: multipartData, method: method) { (result: ResultWithET<String, E>) in
            completion(self.transformResponseType(fromResult: result))
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
        return createMultipartDataTaskWithET(multipartData: multipartData,
                                             method: method,
                                             errorType: E.self) { (data, urlResponse, error) in
                                                self.handleCustomSerializerResponse(data: data, urlResponse: urlResponse, error: error, responseSerializer: responseSerializer, completionHandler: { (resData) in
                                                    responseSerializer.parse(method: method, response: urlResponse as? HTTPURLResponse, data: resData, error: error)
                                                })
        }
    }
}

// MARK: - Multipart requests with ET
extension URLSessionRestApiManager {
    /// Multipart Object call with ET
    ///
    /// - Parameters:
    ///   - multipartData: MultipartData
    ///   - method: RestApiMethod
    ///   - completion: ResultWithET<T, ET>
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call<T: Associated, ET: RestApiError>(multipartData: MultipartData,
                                                      method: RestApiMethod,
                                                      completion: @escaping (_ result: ResultWithET<T, ET>) -> Void) -> URLSessionTask? {
        return createMultipartDataTaskWithET(multipartData: multipartData, method: method, completion: completion)
    }
    
    /// Multipart Array call with ET
    ///
    /// - Parameters:
    ///   - multipartData: MultipartData
    ///   - method: RestApiMethod
    ///   - completion: ResultWithET<[T], ET>
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call<T: Associated, ET: RestApiError>(multipartData: MultipartData,
                                                      method: RestApiMethod,
                                                      completion: @escaping (_ result: ResultWithET<[T], ET>) -> Void) -> URLSessionTask? {
        return createMultipartDataTaskWithET(multipartData: multipartData, method: method, completion: completion)
    }
    
    /// Multipart String call with ET
    ///
    /// - Parameters:
    ///   - multipartData: MultipartData
    ///   - method: RestApiMethod
    ///   - completion: ResultWithET<String, ET>
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call<ET: RestApiError>(multipartData: MultipartData,
                                       method: RestApiMethod,
                                       completion: @escaping (_ result: ResultWithET<String, ET>) -> Void) -> URLSessionTask? {
        return createMultipartDataTaskWithET(multipartData: multipartData, method: method, completion: completion) { [unowned self] (data) in
            completion(self.transformResponseType(fromData: data))
        }
    }
}
