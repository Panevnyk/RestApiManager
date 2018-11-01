//
//  URLSessionRestApiManagerDIContainer.swift
//  RestApiManager
//
//  Created by Panevnyk Vlad on 10/19/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import Foundation

/// URLSessionRestApiManagerDIContainer
public struct URLSessionRestApiManagerDIContainer<E: RestApiError>: RestApiManagerDIContainer {
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
    
    /// Init
    public init(errorType: E.Type,
                urlSession: URLSession = URLSession.shared,
                jsonDecoder: JSONDecoder = JSONDecoder(),
                restApiAlert: RestApiAlert = DefaultRestApiAlert(),
                restApiActivityIndicator: RestApiActivityIndicator = DefaultRestApiActivityIndicator(),
                printRequestInfo: Bool = true) {
        self.errorType = errorType
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
        self.restApiAlert = restApiAlert
        self.restApiActivityIndicator = restApiActivityIndicator
        self.printRequestInfo = printRequestInfo
    }
}
