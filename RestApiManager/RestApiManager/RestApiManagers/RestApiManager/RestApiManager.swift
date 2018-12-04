//
//  RestApiManager.swift
//  Roadwarez
//
//  Created by Panevnyk Vlad on 10/5/17.
//  Copyright © 2017 Roadwarez. All rights reserved.
//

import Foundation

/// RestApiManager
public protocol RestApiManager {

    // ---------------------------------------------------------------------
    // MARK: - Properties
    // ---------------------------------------------------------------------
    
    /// URLSessionRAMDIContainer
    var restApiManagerDIContainer: RestApiManagerDIContainer { get }
    
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
    func call<T: Associated>(method: RestApiMethod, completion: @escaping (_ result: Result<T>) -> Void) -> URLSessionTask?
    
    /// Array call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: Result<[T]>
    /// - Returns: URLSessionTask?
    @discardableResult
    func call<T: Associated>(method: RestApiMethod, completion: @escaping (_ result: Result<[T]>) -> Void) -> URLSessionTask?
    
    /// String call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: Result<String>
    /// - Returns: URLSessionTask?
    @discardableResult
    func call(method: RestApiMethod, completion: @escaping (_ result: Result<String>) -> Void) -> URLSessionTask?
    
    /// Custom response serializer call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - responseSerializer: T where T: ResponseSerializer
    /// - Returns: URLSessionTask?
    @discardableResult
    func call<T: ResponseSerializer>(method: RestApiMethod, responseSerializer: T) -> URLSessionTask?
    
    // ---------------------------------------------------------------------
    // MARK: - Simple requests with ET
    // ---------------------------------------------------------------------
    
    /// Object call with ET
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: ResultWithET<T, ET>
    /// - Returns: URLSessionTask?
    @discardableResult
    func call<T: Associated, ET: RestApiError>(method: RestApiMethod, completion: @escaping (_ result: ResultWithET<T, ET>) -> Void) -> URLSessionTask?
    
    /// Array call with ET
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: ResultWithET<[T], ET>
    /// - Returns: URLSessionTask?
    @discardableResult
    func call<T: Associated, ET: RestApiError>(method: RestApiMethod, completion: @escaping (_ result: ResultWithET<[T], ET>) -> Void) -> URLSessionTask?
    
    /// String call with ET
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: ResultWithET<String, ET>
    /// - Returns: URLSessionTask?
    @discardableResult
    func call<ET: RestApiError>(method: RestApiMethod, completion: @escaping (_ result: ResultWithET<String, ET>) -> Void) -> URLSessionTask?
    
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
    func call<T: Associated>(multipartData: MultipartData, method: RestApiMethod, completion: @escaping (_ result: Result<T>) -> Void) -> URLSessionTask?
    
    /// Multipart Array call
    ///
    /// - Parameters:
    ///   - multipartData: MultipartData
    ///   - method: RestApiMethod
    ///   - completion: Result<[T]>
    /// - Returns: URLSessionTask?
    @discardableResult
    func call<T: Associated>(multipartData: MultipartData, method: RestApiMethod, completion: @escaping (_ result: Result<[T]>) -> Void) -> URLSessionTask?
    
    /// Multipart String call
    ///
    /// - Parameters:
    ///   - multipartData: MultipartData
    ///   - method: RestApiMethod
    ///   - completion: Result<String>
    /// - Returns: URLSessionTask?
    @discardableResult
    func call(multipartData: MultipartData, method: RestApiMethod, completion: @escaping (_ result: Result<String>) -> Void) -> URLSessionTask?
    
    /// Multipart Custom response serializer call
    ///
    /// - Parameters:
    ///   - multipartData: MultipartData
    ///   - method: RestApiMethod
    ///   - responseSerializer: T where T: ResponseSerializer
    /// - Returns: URLSessionTask?
    @discardableResult
    func call<T: ResponseSerializer>(multipartData: MultipartData, method: RestApiMethod, responseSerializer: T) -> URLSessionTask?
    
    // ---------------------------------------------------------------------
    // MARK: - Multipart requests with ET
    // ---------------------------------------------------------------------
    
    /// Multipart Object call with ET
    ///
    /// - Parameters:
    ///   - multipartData: MultipartData
    ///   - method: RestApiMethod
    ///   - completion: ResultWithET<T, ET>
    /// - Returns: URLSessionTask?
    @discardableResult
    func call<T: Associated, ET: RestApiError>(multipartData: MultipartData,
                                                      method: RestApiMethod,
                                                      completion: @escaping (_ result: ResultWithET<T, ET>) -> Void) -> URLSessionTask?
    
    /// Multipart Array call with ET
    ///
    /// - Parameters:
    ///   - multipartData: MultipartData
    ///   - method: RestApiMethod
    ///   - completion: ResultWithET<[T], ET>
    /// - Returns: URLSessionTask?
    @discardableResult
    func call<T: Associated, ET: RestApiError>(multipartData: MultipartData,
                                                      method: RestApiMethod,
                                                      completion: @escaping (_ result: ResultWithET<[T], ET>) -> Void) -> URLSessionTask?
    
    /// Multipart String call with ET
    ///
    /// - Parameters:
    ///   - multipartData: MultipartData
    ///   - method: RestApiMethod
    ///   - completion: ResultWithET<String, ET>
    /// - Returns: URLSessionTask?
    @discardableResult
    func call<ET: RestApiError>(multipartData: MultipartData,
                                       method: RestApiMethod,
                                       completion: @escaping (_ result: ResultWithET<String, ET>) -> Void) -> URLSessionTask?
}
