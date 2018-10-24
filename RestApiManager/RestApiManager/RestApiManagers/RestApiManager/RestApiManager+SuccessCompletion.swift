//
//  ExtensionRestApiManagerSuccessCompletion.swift
//  FastTableViewDemo
//
//  Created by Panevnyk Vlad on 11/6/17.
//  Copyright © 2017 Panevnyk Vlad. All rights reserved.
//

import Foundation

// MARK: Call methods with SuccessCompletion
extension RestApiManager {
    
    // ---------------------------------------------------------------------
    // MARK: - Simple requests
    // ---------------------------------------------------------------------
    
    /// Object call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - indicator: Bool = false
    ///   - errorAlert: Bool = false
    ///   - successCompletion: T
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call<T: Associated>(method: RestApiMethod,
                                    indicator: Bool = false,
                                    errorAlert: Bool = false,
                                    successCompletion: @escaping (_ result: T) -> Void) -> URLSessionTask? {
        return call(method: method,
                    indicator: indicator,
                    errorAlert: errorAlert) { (result: Result<T>) in
                        switch result {
                        case .success(let obj):
                            successCompletion(obj)
                        default:
                            break
                        }
        }
    }
    
    /// Array call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - indicator: Bool = false
    ///   - errorAlert: Bool = false
    ///   - successCompletion: [T]
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call<T: Associated>(method: RestApiMethod,
                                    indicator: Bool = false,
                                    errorAlert: Bool = false,
                                    successCompletion: @escaping (_ result: [T]) -> Void) -> URLSessionTask? {
        return call(method: method,
                    indicator: indicator,
                    errorAlert: errorAlert) { (result: Result<[T]>) in
                        switch result {
                        case .success(let obj):
                            successCompletion(obj)
                        default:
                            break
                        }
        }
    }
    
    /// String call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - indicator: Bool = false
    ///   - errorAlert: Bool = false
    ///   - successCompletion: String
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call(method: RestApiMethod,
                     indicator: Bool = false,
                     errorAlert: Bool = false,
                     successCompletion: @escaping (_ result: String) -> Void) -> URLSessionTask? {
        return call(method: method,
                    indicator: indicator,
                    errorAlert: errorAlert) { (result: Result<String>) in
                        switch result {
                        case .success(let obj):
                            successCompletion(obj)
                        default:
                            break
                        }
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
    ///   - indicator: Bool = false
    ///   - errorAlert: Bool = false
    ///   - successCompletion: T
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call<T: Associated>(multipartData: MultipartData,
                                    method: RestApiMethod,
                                    indicator: Bool = false,
                                    errorAlert: Bool = false,
                                    successCompletion: @escaping (_ result: T) -> Void) -> URLSessionTask? {
        return call(multipartData: multipartData,
                    method: method,
                    indicator: indicator,
                    errorAlert: errorAlert) { (result: Result<T>) in
                        switch result {
                        case .success(let obj):
                            successCompletion(obj)
                        default:
                            break
                        }
        }
    }
    
    /// Multipart Array call
    ///
    /// - Parameters:
    ///   - multipartData: MultipartData
    ///   - method: RestApiMethod
    ///   - indicator: Bool = false
    ///   - errorAlert: Bool = false
    ///   - successCompletion: [T]
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call<T: Associated>(multipartData: MultipartData,
                                    method: RestApiMethod,
                                    indicator: Bool = false,
                                    errorAlert: Bool = false,
                                    successCompletion: @escaping (_ result: [T]) -> Void) -> URLSessionTask? {
        return call(multipartData: multipartData,
                    method: method,
                    indicator: indicator,
                    errorAlert: errorAlert) { (result: Result<[T]>) in
                        switch result {
                        case .success(let obj):
                            successCompletion(obj)
                        default:
                            break
                        }
        }
    }
    
    /// Multipart String call
    ///
    /// - Parameters:
    ///   - multipartData: MultipartData
    ///   - method: RestApiMethod
    ///   - indicator: Bool = false
    ///   - errorAlert: Bool = false
    ///   - successCompletion: String
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call(multipartData: MultipartData,
                     method: RestApiMethod,
                     indicator: Bool = false,
                     errorAlert: Bool = false,
                     successCompletion: @escaping (_ result: String) -> Void) -> URLSessionTask? {
        return call(multipartData: multipartData,
                    method: method,
                    indicator: indicator,
                    errorAlert: errorAlert) { (result: Result<String>) in
                        switch result {
                        case .success(let obj):
                            successCompletion(obj)
                        default:
                            break
                        }
        }
    }
}
