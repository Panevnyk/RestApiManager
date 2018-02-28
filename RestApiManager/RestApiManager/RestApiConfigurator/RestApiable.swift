//
//  RestApiable.swift
//  FastTableViewDemo
//
//  Created by Panevnyk Vlad on 11/3/17.
//  Copyright © 2017 Panevnyk Vlad. All rights reserved.
//

import Foundation

/// Cake Pattern
/// RestApiabe
public protocol RestApiable {
    var restApiManager: RestApiManager { get }
}

extension RestApiable {
    /// RestApiManager
    public var restApiManager: RestApiManager {
        return RestApiConfigurator.shared.restApiManager
    }
}
