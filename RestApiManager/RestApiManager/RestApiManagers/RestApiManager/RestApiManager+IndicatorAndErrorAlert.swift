//
//  ExtensionRestApiManagerWithLoadIndicator.swift
//  FastTableViewDemo
//
//  Created by Panevnyk Vlad on 11/6/17.
//  Copyright © 2017 Panevnyk Vlad. All rights reserved.
//

import Foundation
import UIKit

// MARK: Call methods with Indicator and ErrorAlert
extension RestApiManager {
    
    // ---------------------------------------------------------------------
    // MARK: - Simple requests
    // ---------------------------------------------------------------------
    
    /// Object call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - indicator: Bool
    ///   - errorAlert: Bool = false
    ///   - completion: Result<T>
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call<T: Associated>(method: RestApiMethod,
                                    indicator: Bool = false,
                                    errorAlert: Bool = false,
                                    completion: @escaping (_ result: Result<T>) -> Void) -> URLSessionTask? {
        showIndicator(indicator)
        return call(method: method) { (result: Result<T>) in
            self.showErrorAlert(errorAlert, result: result)
            completion(result)
            self.hideIndicator(indicator)
        }
    }
    
    /// Array call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - indicator: Bool
    ///   - errorAlert: Bool = false
    ///   - completion: Result<[T]>
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call<T: Associated>(method: RestApiMethod,
                                    indicator: Bool = false,
                                    errorAlert: Bool = false,
                                    completion: @escaping (_ result: Result<[T]>) -> Void) -> URLSessionTask? {
        showIndicator(indicator)
        return call(method: method) { (result: Result<[T]>) in
            self.showErrorAlert(errorAlert, result: result)
            completion(result)
            self.hideIndicator(indicator)
        }
    }
    
    /// String call
    ///
    /// - Parameters:
    ///   - method: RestApiMethod
    ///   - indicator: Bool
    ///   - errorAlert: Bool = false
    ///   - completion: Result<String>
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call(method: RestApiMethod,
                     indicator: Bool = false,
                     errorAlert: Bool = false,
                     completion: @escaping (_ result: Result<String>) -> Void) -> URLSessionTask? {
        showIndicator(indicator)
        return call(method: method) { (result: Result<String>) in
            self.showErrorAlert(errorAlert, result: result)
            completion(result)
            self.hideIndicator(indicator)
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
    ///   - indicator: Bool
    ///   - errorAlert: Bool = false
    ///   - completion: Result<T>
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call<T: Associated>(multipartData: MultipartData,
                                    method: RestApiMethod,
                                    indicator: Bool = false,
                                    errorAlert: Bool = false,
                                    completion: @escaping (_ result: Result<T>) -> Void) -> URLSessionTask? {
        showIndicator(indicator)
        return call(multipartData: multipartData, method: method) { (result: Result<T>) in
            self.showErrorAlert(errorAlert, result: result)
            completion(result)
            self.hideIndicator(indicator)
        }
    }
    
    /// Multipart Array call
    ///
    /// - Parameters:
    ///   - multipartData: MultipartData
    ///   - method: RestApiMethod
    ///   - indicator: Bool
    ///   - errorAlert: Bool = false
    ///   - completion: Result<[T]>
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call<T: Associated>(multipartData: MultipartData,
                                    method: RestApiMethod,
                                    indicator: Bool = false,
                                    errorAlert: Bool = false,
                                    completion: @escaping (_ result: Result<[T]>) -> Void) -> URLSessionTask? {
        showIndicator(indicator)
        return call(multipartData: multipartData, method: method) { (result: Result<[T]>) in
            self.showErrorAlert(errorAlert, result: result)
            completion(result)
            self.hideIndicator(indicator)
        }
    }
    
    /// Multipart String call
    ///
    /// - Parameters:
    ///   - multipartData: MultipartData
    ///   - method: RestApiMethod
    ///   - indicator: Bool
    ///   - errorAlert: Bool = false
    ///   - completion: Result<String>
    /// - Returns: URLSessionTask?
    @discardableResult
    public func call(multipartData: MultipartData,
                     method: RestApiMethod,
                     indicator: Bool = false,
                     errorAlert: Bool = false,
                     completion: @escaping (_ result: Result<String>) -> Void) -> URLSessionTask? {
        showIndicator(indicator)
        return call(multipartData: multipartData, method: method) { (result: Result<String>) in
            self.showErrorAlert(errorAlert, result: result)
            completion(result)
            self.hideIndicator(indicator)
        }
    }
}

// MARK: - Show Error Alert
private extension RestApiManager {
    func showErrorAlert<T: Associated>(_ showErrorAlert: Bool, result: Result<T>) {
        guard showErrorAlert else { return }
        
        switch result {
        case .failure(let error):
            restApiManagerDIContainer.restApiAlert.show(error: error)
        default:
            break
        }
    }
}

// MARK: - StatusBar load indicator
private extension RestApiManager {
    func showStatusBarLoadIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func hideStatusBarLoadIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

// MARK: - Load indicator
private extension RestApiManager {
    func showIndicator(_ indicator: Bool) {
        guard indicator else { return }
        restApiManagerDIContainer.restApiActivityIndicator.show()
    }
    
    func hideIndicator(_ indicator: Bool) {
        guard indicator else { return }
        restApiManagerDIContainer.restApiActivityIndicator.hide()
    }
}
