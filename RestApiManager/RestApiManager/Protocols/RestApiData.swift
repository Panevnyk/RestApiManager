//
//  RestApiData.swift
//  FastTableViewDemo
//
//  Created by Panevnyk Vlad on 11/7/17.
//  Copyright © 2017 Panevnyk Vlad. All rights reserved.
//

import Foundation

/// RestApiData
public struct RestApiData {
    public var url: String
    public var httpMethod: HttpMethod
    public var headers: [String: String]?
    public var parameters: Any?
    public var keyPath: String?
    
    public init(url: String,
                httpMethod: HttpMethod,
                headers: [String: String]? = nil,
                parameters: ParametersProtocol? = nil,
                keyPath: String? = nil) {
        self.url = url
        self.httpMethod = httpMethod
        self.headers = headers
        self.keyPath = keyPath
        self.parameters = parameters?.parametersValue
    }
}

// MARK: - url with parameters String for GET request
public extension RestApiData {
    var urlWithParametersString: String {
        guard let parameters = parameters as? [String: Any] else {
            return url
        }
        var parametersString = ""
        for (offset: i, element: (key: key, value: value)) in parameters.enumerated() {
            parametersString += "\(key)=\(value)"
            if i < parameters.count - 1 {
                parametersString += "&"
            }
        }
        parametersString = parametersString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        if !parametersString.isEmpty {
            parametersString = "?" + parametersString
        }
        return url + parametersString
    }
}
