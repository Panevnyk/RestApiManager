//
//  ExampleRestApiError.swift
//  Example
//
//  Created by Panevnyk Vlad on 11/19/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import RestApiManager

final class ExampleRestApiError: RestApiError {
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
    
    /// method for handle error by response, if parse to Error success, method will be return Error
    ///
    /// - Parameters:
    ///   - error: Error?
    ///   - data: Data? for parsing to Error
    /// - Returns: ExampleRestApiError
    static func handle(error: Error?, data: Data?) -> ExampleRestApiError? {
        if let error = error {
            return ExampleRestApiError(error: error)
        } else if let data = data {
            guard !data.isEmpty else {
                return nil
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject],
                    let code = json[RestApiConstants.code] as? Int,
                    let message = json[RestApiConstants.message] as? String {
                    
                    let error = ExampleRestApiError(code: code, details: message)
                    return error
                } else {
                    return nil
                }
            } catch let error as NSError {
                return ExampleRestApiError(error: error)
            }
        } else {
            return ExampleRestApiError.unknown
        }
    }
}
