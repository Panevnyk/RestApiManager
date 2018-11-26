//
//  RestApiError.swift
//  FastTableViewDemo
//
//  Created by Panevnyk Vlad on 11/3/17.
//  Copyright © 2017 Panevnyk Vlad. All rights reserved.
//

import Foundation

/// RestApiError
public protocol RestApiError: Error {
    /// Fields
    var code: Int { get set }
    var details: String { get set }
    
    /// Inits
    init()
    init(error: Error)
    init(code: Int)
    init(code: Int, details: String)
    
    /// handler error
    /// if return nil - response will be parsed as .success()
    ///
    /// - Parameters:
    ///   - error: Error?
    ///   - urlResponse: URLResponse?
    ///   - data: Data?
    /// - Returns: AlwaysFailureRestApiError
    static func handle(error: Error?, urlResponse: URLResponse?, data: Data?) -> Self?
}

extension RestApiError {
    /// Create RestApiError instance with unknown error code
    public static var unknown: Self {
        return Self()
    }
    
    /// Create RestApiError instance with noData error code
    public static var noData: Self {
        return Self(code: RestApiErrorCode.noData)
    }
    
    /// Create RestApiError instance with noInternetConnection error code
    public static var noInternetConnection: Self {
        return Self(code: RestApiErrorCode.noInternetConnection)
    }
}
