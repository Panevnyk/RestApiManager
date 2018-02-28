//
//  RestApiConfigurator.swift
//  FastTableViewDemo
//
//  Created by Panevnyk Vlad on 11/27/17.
//  Copyright © 2017 Panevnyk Vlad. All rights reserved.
//

/// RestApiConfigurator
public class RestApiConfigurator {
    /// RestApiConfigurator
    public static let shared = RestApiConfigurator()
    /// RestApiError
    public var errorType: RestApiError.Type = DefaultRestApiError.self
    /// RestApiAlert
    public var restApiAlert: RestApiAlert = DefaultRestApiAlert()
    /// RestApiActivityIndicator
    public var restApiActivityIndicator: RestApiActivityIndicator = DefaultRestApiActivityIndicator()
    /// PrintingRequest
    public var printRequestInfo = true
    /// RestApiManager
    public var restApiManager: RestApiManager = URLSessionRestApiManager()
}
