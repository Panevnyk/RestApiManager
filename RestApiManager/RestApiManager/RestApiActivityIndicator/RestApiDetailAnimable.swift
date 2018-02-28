//
//  RestApiDetailAnimable.swift
//  FastTableViewDemo
//
//  Created by Panevnyk Vlad on 11/6/17.
//  Copyright © 2017 Panevnyk Vlad. All rights reserved.
//

import UIKit

/// RestApiDetailAnimable
public protocol RestApiDetailAnimable {}

extension RestApiDetailAnimable where Self: UIView {
    /// showView
    public func showView() {
        showView(completition: nil)
    }
    
    /// showView
    ///
    /// - Parameter completition: completion closure
    public func showView(completition: (() -> Void)?) {
        self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: { (_) in
            if let completition = completition {
                completition()
            }
        })
    }
    
    /// hideView
    public func hideView() {
        hideView(completition: nil)
    }
    
    /// hideView
    ///
    /// - Parameter completition: hide closure
    public func hideView(completition: (() -> Void)?) {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        }, completion: { (_) in
            self.transform = CGAffineTransform.identity
            if let completition = completition {
                completition()
            }
        })
    }
}
