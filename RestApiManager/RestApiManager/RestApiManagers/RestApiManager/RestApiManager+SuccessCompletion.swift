//
//  ExtensionRestApiManagerSuccessCompletion.swift
//  FastTableViewDemo
//
//  Created by Panevnyk Vlad on 11/6/17.
//  Copyright © 2017 Panevnyk Vlad. All rights reserved.
//

import Foundation

// MARK: - RestApiAlert
extension RestApiManager {
    public var restApiAlert: RestApiAlert {
        return RestApiConfigurator.shared.restApiAlert
    }
}

// MARK: Call method with Success completion
extension RestApiManager {
    
    /// Object call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: Result<T>
    public func call<T: Associated>(method: RestApiMethod, indicator: Bool = false, successCompletion: @escaping (_ result: T) -> Void) {
        call(method: method, indicator: indicator) { (result: Result<T>) in
            switch result {
            case .success(let obj):
                successCompletion(obj)
            case .failure(let error):
                self.restApiAlert.show(error: error)
            }
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
    public func call<T: Associated>(method: RestApiMethod, indicator: Bool = false, successCompletion: @escaping (_ result: [T]) -> Void) {
        call(method: method, indicator: indicator) { (result: Result<[T]>) in
            switch result {
            case .success(let obj):
                successCompletion(obj)
            case .failure(let error):
                self.restApiAlert.show(error: error)
            }
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
                                    indicator: Bool = false,
                                    successCompletion: @escaping (_ result: T) -> Void) {
        call(multipartData: multipartData, method: method, indicator: indicator) { (result: Result<T>) in
            switch result {
            case .success(let obj):
                successCompletion(obj)
            case .failure(let error):
                self.restApiAlert.show(error: error)
            }
        }
    }
    
    /// String call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: Result<String>
    public func call(method: RestApiMethod, indicator: Bool = false, successCompletion: @escaping (_ result: String) -> Void) {
        call(method: method, indicator: indicator) { (result: Result<String>) in
            switch result {
            case .success(let obj):
                successCompletion(obj)
            case .failure(let error):
                self.restApiAlert.show(error: error)
            }
        }
    }
}
