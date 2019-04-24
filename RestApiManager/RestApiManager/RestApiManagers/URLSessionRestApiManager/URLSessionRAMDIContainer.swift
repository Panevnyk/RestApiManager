//
//  URLSessionRAMDIContainer.swift
//  RestApiManager
//
//  Created by Panevnyk Vlad on 10/19/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import Foundation

/// URLSessionRAMDIContainer
public struct URLSessionRAMDIContainer<E: RestApiError>: RestApiManagerDIContainer {
    /// RestApiError
    public var errorType: E.Type
    /// URLSession
    public var urlSession: URLSession
    /// JSONDecoder
    public var jsonDecoder: JSONDecoder
    /// RestApiAlert
    public var restApiAlert: RestApiAlert
    /// RestApiActivityIndicator
    public var restApiActivityIndicator: RestApiActivityIndicator
    /// PrintingRequest
    public var printRequestInfo: Bool
    /// TimeoutInterval
    public var timeoutInterval: Double
    
    /// init
    ///
    /// - Parameters:
    ///   - errorType: E.Type
    ///   - urlSession: URLSession
    ///   - jsonDecoder: JSONDecoder
    ///   - restApiAlert: RestApiAlert
    ///   - restApiActivityIndicator: RestApiActivityIndicator
    ///   - printRequestInfo: Bool
    public init(errorType: E.Type,
                urlSession: URLSession = URLSession.shared,
                jsonDecoder: JSONDecoder = JSONDecoder(),
                restApiAlert: RestApiAlert = DefaultRestApiAlert(),
                restApiActivityIndicator: RestApiActivityIndicator = DefaultRestApiActivityIndicator(),
                printRequestInfo: Bool = true,
                timeoutInterval: Double = 15.0) {
        self.errorType = errorType
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
        self.restApiAlert = restApiAlert
        self.restApiActivityIndicator = restApiActivityIndicator
        self.printRequestInfo = printRequestInfo
        self.timeoutInterval = timeoutInterval
    }
}
