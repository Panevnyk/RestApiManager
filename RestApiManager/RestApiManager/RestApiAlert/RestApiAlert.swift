//
//  RestApiAlert.swift
//  FastTableViewDemo
//
//  Created by Panevnyk Vlad on 2/20/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

/// RestApiAlert
public protocol RestApiAlert {
    func show(error: RestApiError)
    func show(title: String, message: String, completion: (() -> Void)?)
}
