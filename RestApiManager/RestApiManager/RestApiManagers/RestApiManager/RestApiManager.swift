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
    // MARK: - Simple requests
    // ---------------------------------------------------------------------
    
    /// Object call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: Result<T>
    func call<T: Associated>(method: RestApiMethod, completion: @escaping (_ result: Result<T>) -> Void)
    
    /// Array call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: Result<[T]>
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: Result<T>
    func call<T: Associated>(method: RestApiMethod, completion: @escaping (_ result: Result<[T]>) -> Void)
    
    /// String call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: Result<String>
    func call(method: RestApiMethod, completion: @escaping (_ result: Result<String>) -> Void)
    
    /// Custom response serializer call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - responseSerializer: T where T: ResponseSerializer
    func call<T: ResponseSerializer>(method: RestApiMethod, responseSerializer: T)
    
    // ---------------------------------------------------------------------
    // MARK: - Multipart
    // ---------------------------------------------------------------------
    
    /// Multipart Object call
    ///
    /// - Parameters:
    ///   - multipartData: MultipartData
    ///   - method: RestApiMethod
    ///   - completion: Result<T>
    func call<T: Associated>(multipartData: MultipartData, method: RestApiMethod, completion: @escaping (_ result: Result<T>) -> Void)
    
    /// Multipart Array call
    ///
    /// - Parameters:
    ///   - multipartData: MultipartData
    ///   - method: RestApiMethod
    ///   - completion: Result<[T]>
    func call<T: Associated>(multipartData: MultipartData, method: RestApiMethod, completion: @escaping (_ result: Result<[T]>) -> Void)
    
    /// Multipart String call
    ///
    /// - Parameters:
    ///   - multipartData: MultipartData
    ///   - method: RestApiMethod
    ///   - completion: Result<String>
    func call(multipartData: MultipartData, method: RestApiMethod, completion: @escaping (_ result: Result<String>) -> Void)
    
    /// Multipart Custom response serializer call
    ///
    /// - Parameters:
    ///   - multipartData: MultipartData
    ///   - method: RestApiMethod
    ///   - responseSerializer: T where T: ResponseSerializer
    func call<T: ResponseSerializer>(multipartData: MultipartData, method: RestApiMethod, responseSerializer: T)
}
