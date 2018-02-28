//
//  ExtensionURLRequest.swift
//  FastTableViewDemo
//
//  Created by Panevnyk Vlad on 11/7/17.
//  Copyright © 2017 Panevnyk Vlad. All rights reserved.
//

import Foundation

extension URLRequest {
    
    mutating public func addHttpBody(parameters: Any) {
        do {
            let jsonObject = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            httpBody = jsonObject
        } catch let error {
            print("FAIL add http body: \(error)")
        }
    }
    
    mutating public func addHeaders(_ headers: [String: String]?) {
        var headers: [String: String] = headers ?? [:]
        headers["Content-Type"] = "application/json"
        for (headerField, value) in headers {
            setValue(value, forHTTPHeaderField: headerField)
        }
    }
    
}
