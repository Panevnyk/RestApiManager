//
//  RestApiMethod.swift
//  Roadwarez
//
//  Created by Panevnyk Vlad on 10/24/17.
//  Copyright © 2017 Roadwarez. All rights reserved.
//

import Foundation

/// RestApiMethod
public protocol RestApiMethod {
    var data: RestApiData { get }
}

/// HttpMethod
public enum HttpMethod: String {
    case options = "OPTIONS"
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case trace = "TRACE"
    case connect = "CONNECT"
}
