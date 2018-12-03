//
//  RestApiManager+URLRequest.swift
//  FastTableViewDemo
//
//  Created by Panevnyk Vlad on 11/27/17.
//  Copyright © 2017 Panevnyk Vlad. All rights reserved.
//

import Foundation

// MARK: - Request
public extension RestApiManager {
    func request(method: RestApiMethod) -> URLRequest? {
        let urlString = method.data.httpMethod == .get ? method.data.urlWithParametersString : method.data.url
        guard let url = URL(string: urlString) else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 15.0
        urlRequest.httpMethod = method.data.httpMethod.rawValue
        urlRequest.addHeaders(method.data.headers)
        if method.data.httpMethod != .get {
            urlRequest.addHttpBody(parameters: method.data.parameters)
        }
        return urlRequest
    }
}
