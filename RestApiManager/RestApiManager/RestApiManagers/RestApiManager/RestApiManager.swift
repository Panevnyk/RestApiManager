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
    
    /// Multipart call
    ///
    /// - Parameters:
    ///   - multipartData: MultipartData
    ///   - method: RestApiMethod
    ///   - completion: Result<T>
    func call<T: Associated>(multipartData: MultipartData, method: RestApiMethod, completion: @escaping (_ result: Result<T>) -> Void)
    
    /// Custom response serializer call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - responseSerializer: T where T: ResponseSerializer
    func call<T: ResponseSerializer>(method: RestApiMethod, responseSerializer: T)
    
    /// String call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: Result<String>
    func call(method: RestApiMethod, completion: @escaping (_ result: Result<String>) -> Void)
}
