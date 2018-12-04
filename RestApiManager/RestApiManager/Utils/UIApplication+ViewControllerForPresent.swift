//
//  UIApplication+ViewControllerForPresent.swift
//  FastTableViewDemo
//
//  Created by Panevnyk Vlad on 2/27/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import UIKit

/// presentationViewController
public extension UIApplication {
    class var presentationViewController: UIViewController? {
        var targetForPresent = UIApplication.shared.keyWindow?.rootViewController
        
        while targetForPresent?.presentedViewController != nil {
            targetForPresent = targetForPresent?.presentedViewController
        }
        
        return targetForPresent
    }
}
