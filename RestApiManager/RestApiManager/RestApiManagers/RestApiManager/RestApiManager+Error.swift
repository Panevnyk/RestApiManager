//
//  RestApiManager+Error.swift
//  FastTableViewDemo
//
//  Created by Panevnyk Vlad on 11/27/17.
//  Copyright © 2017 Panevnyk Vlad. All rights reserved.
//

import Foundation

extension RestApiManager {
    var errorType: RestApiError.Type {
        return RestApiConfigurator.shared.errorType
    }
}
