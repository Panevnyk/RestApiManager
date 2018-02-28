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
    var url: String
    var httpMethod: HttpMethod
    var headers: [String: String]?
    var parameters: Any
    var keyPath: String?
    
    init(url: String,
         httpMethod: HttpMethod,
         headers: [String: String]? = nil,
         parameters: ParametersProtocol? = nil,
         keyPath: String? = nil) {
        self.url = url
        self.httpMethod = httpMethod
        self.headers = headers
        self.keyPath = keyPath
        self.parameters = parameters?.parametersValue ?? [:]
    }
}

extension RestApiData {
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
