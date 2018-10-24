//
//  RestApiManagerDIFabric.swift
//  RestApiManager
//
//  Created by Panevnyk Vlad on 10/19/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import Foundation

/// RestApiManagerDIFabric
public protocol RestApiManagerDIFabric {
    /// RestApiAlert
    var restApiAlert: RestApiAlert { get }
    /// RestApiActivityIndicator
    var restApiActivityIndicator: RestApiActivityIndicator { get }
    /// PrintingRequest
    var printRequestInfo: Bool { get }
}
