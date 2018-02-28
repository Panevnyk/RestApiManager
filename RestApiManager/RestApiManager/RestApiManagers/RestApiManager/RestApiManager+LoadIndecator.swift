//
//  ExtensionRestApiManagerWithLoadIndicator.swift
//  FastTableViewDemo
//
//  Created by Panevnyk Vlad on 11/6/17.
//  Copyright © 2017 Panevnyk Vlad. All rights reserved.
//

import Foundation
import UIKit

// MARK: - RestApiActivityIndicator
extension RestApiManager {
    public var restApiActivityIndicator: RestApiActivityIndicator {
        return RestApiConfigurator.shared.restApiActivityIndicator
    }
}

// MARK: Call method with Load indicator
extension RestApiManager {
    /// Object call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: Result<T>
    public func call<T: Associated>(method: RestApiMethod, indicator: Bool, completion: @escaping (_ result: Result<T>) -> Void) {
        showIndicator(indicator)
        call(method: method) { (result: Result<T>) in
            completion(result)
            self.hideIndicator(indicator)
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
    public func call<T: Associated>(method: RestApiMethod, indicator: Bool, completion: @escaping (_ result: Result<[T]>) -> Void) {
        showIndicator(indicator)
        call(method: method) { (result: Result<[T]>) in
            completion(result)
            self.hideIndicator(indicator)
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
                                    indicator: Bool,
                                    completion: @escaping (_ result: Result<T>) -> Void) {
        showIndicator(indicator)
        call(multipartData: multipartData, method: method) { (result: Result<T>) in
            completion(result)
            self.hideIndicator(indicator)
        }
    }
    
    /// String call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - completion: Result<String>
    public func call(method: RestApiMethod, indicator: Bool, completion: @escaping (_ result: Result<String>) -> Void) {
        showIndicator(indicator)
        call(method: method) { (result: Result<String>) in
            completion(result)
            self.hideIndicator(indicator)
        }
    }
}

// MARK: - StatusBar load indicator
extension RestApiManager {
    private func showStatusBarLoadIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    private func hideStatusBarLoadIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

// MARK: - Load indicator
extension RestApiManager {
    private func showIndicator(_ indicator: Bool) {
        if indicator {
            restApiActivityIndicator.show()
        }
    }
    
    private func hideIndicator(_ indicator: Bool) {
        if indicator {
            restApiActivityIndicator.hide()
        }
    }
}
