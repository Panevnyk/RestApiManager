//
//  Result.swift
//  FastTableViewDemo
//
//  Created by Panevnyk Vlad on 11/3/17.
//  Copyright © 2017 Panevnyk Vlad. All rights reserved.
//

import Foundation

/// Result
///
/// - success: <T>
/// - failure: RestApiError
public enum Result<T> {
    case success(T)
    case failure(RestApiError)
}

/// ResultWithE
///
/// - success: <T>
/// - failure: <E: RestApiError>
public enum ResultWithE<T, E: RestApiError> {
    case success(T)
    case failure(E)
}
