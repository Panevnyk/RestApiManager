//
//  DefaultRestApiError.swift
//  FastTableViewDemo
//
//  Created by Panevnyk Vlad on 11/27/17.
//  Copyright © 2017 Panevnyk Vlad. All rights reserved.
//

import Foundation

/// RestApiError
public class DefaultRestApiError: RestApiError {
    /// Rest api error code
    public var code = 0
    
    /// Rest api details
    public var details = ""
    
    /// handleError
    ///
    /// - Parameters:
    ///   - error: Error?
    ///   - data: Data?
    public static func handle(error: Error?, urlResponse: URLResponse?, data: Data?) -> Self? {
        return nil
    }
    
    /// Empty Init
    required convenience public init() {
        self.init(code: RestApiErrorCode.unknown, details: "")
    }
    
    /// Init
    ///
    /// - Parameters:
    ///   - error: Error
    required convenience public init(error: Error) {
        self.init(code: RestApiErrorCode.unknown, details: error.localizedDescription)
    }
    
    /// Init
    ///
    /// - Parameters:
    ///   - code: Int
    required convenience public init(code: Int) {
        self.init(code: code, details: "")
    }
    
    /// Init
    ///
    /// - Parameters:
    ///   - code: Int
    ///   - details: String
    required public init(code: Int, details: String) {
        self.code = code
        self.details = details
    }
}
