//
//  Result.swift
//  FastTableViewDemo
//
//  Created by Panevnyk Vlad on 11/3/17.
//  Copyright © 2017 Panevnyk Vlad. All rights reserved.
//

import Foundation

/// Result
public enum Result<T> {
    case success(T)
    case failure(RestApiError)
}
