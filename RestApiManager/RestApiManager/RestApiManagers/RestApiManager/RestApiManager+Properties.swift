//
//  RestApiManager+Error.swift
//  FastTableViewDemo
//
//  Created by Panevnyk Vlad on 11/27/17.
//  Copyright © 2017 Panevnyk Vlad. All rights reserved.
//

import Foundation

/// RestApiError
extension RestApiManager {
    var errorType: RestApiError.Type {
        return RestApiConfigurator.shared.errorType
    }
}

/// JSONDecoder
extension RestApiManager {
    var jsonDecoder: JSONDecoder {
        return RestApiConfigurator.shared.jsonDecoder
    }
}

/// URLSession
extension RestApiManager {
    var urlSession: URLSession {
        return RestApiConfigurator.shared.urlSession
    }
}
