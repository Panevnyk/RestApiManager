//
//  RestApiActivityIndicator.swift
//  FastTableViewDemo
//
//  Created by Panevnyk Vlad on 2/20/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import UIKit

/// RestApiActivityIndicator
public protocol RestApiActivityIndicator {
    func show()
    func show(onView view: UIView)
    func hide()
}
