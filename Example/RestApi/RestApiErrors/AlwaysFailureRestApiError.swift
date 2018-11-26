//
//  AlwaysFailureRestApiError.swift
//  Example
//
//  Created by Panevnyk Vlad on 11/19/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import RestApiManager

final class AlwaysFailureRestApiError: RestApiError {
    // MARK: - Properties
    var code: Int
    var details: String
    
    // MARK: - Inits
    convenience init() {
        self.init(code: 0)
    }
    
    convenience init(error: Error) {
        let nsError = error as NSError
        self.init(code: nsError.code, details: nsError.localizedDescription)
    }
    
    convenience init(code: Int) {
        self.init(code: code, details: "")
    }
    
    init(code: Int, details: String) {
        self.code = code
        self.details = details
    }
    
    // MARK: - Handle
    
    /// method for handle error by response, always AlwaysFailureRestApiError
    ///
    /// - Parameters:
    ///   - error: Error?
    ///   - urlResponse: URLResponse?
    ///   - data: Data?
    /// - Returns: AlwaysFailureRestApiError
    static func handle(error: Error?, urlResponse: URLResponse?, data: Data?) -> AlwaysFailureRestApiError? {
        return AlwaysFailureRestApiError(code: 0, details: "AlwaysFailureRestApiError")
    }
}
