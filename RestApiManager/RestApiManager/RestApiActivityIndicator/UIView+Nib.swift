//
//  ExtensionUIViewNib.swift
//  FastTableViewDemo
//
//  Created by Panevnyk Vlad on 11/6/17.
//  Copyright © 2017 Panevnyk Vlad. All rights reserved.
//

import UIKit

/// Nib
public extension UIView {
    /// Add Self Nibfile
    @discardableResult
    func addSelfNibUsingConstraints(nibName: String) -> UIView? {
        guard let nibView = loadSelfNib(nibName: nibName) else {
            assert(true, "---- UIView Extension Nib file not found ----")
            return nil
        }
        addSubviewUsingConstraints(view: nibView)
        return nibView
    }
    
    @discardableResult
    func addSelfNibUsingConstraints() -> UIView? {
        guard let nibView = loadSelfNib() else {
            assert(true, "---- UIView Extension Nib file not found ----")
            return nil
        }
        addSubviewUsingConstraints(view: nibView)
        return nibView
    }
    
    /// Load Nibfile
    func loadSelfNib() -> UIView? {
        let nibName = String(describing: type(of: self))
        if let nibFiles = Bundle.main.loadNibNamed(nibName, owner: self, options: nil),
            nibFiles.count > 0 {
            return nibFiles.first as? UIView
        }
        return nil
    }
    
    func loadSelfNib(nibName: String) -> UIView? {
        if let nibFiles = Bundle.main.loadNibNamed(nibName, owner: self, options: nil), nibFiles.count > 0 {
            return nibFiles.first as? UIView
        }
        return nil
    }
    
    /// Add subview
    func addSubviewUsingConstraints(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        let left = NSLayoutConstraint(item: view,
                                      attribute: .left,
                                      relatedBy: .equal,
                                      toItem: self,
                                      attribute: .left,
                                      multiplier: 1,
                                      constant: 0)
        let top = NSLayoutConstraint(item: view,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: self,
                                     attribute: .top,
                                     multiplier: 1,
                                     constant: 0)
        let right = NSLayoutConstraint(item: self,
                                       attribute: .trailing,
                                       relatedBy: .equal,
                                       toItem: view,
                                       attribute: .trailing,
                                       multiplier: 1,
                                       constant: 0)
        let bottom = NSLayoutConstraint(item: self,
                                        attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: view,
                                        attribute: .bottom,
                                        multiplier: 1,
                                        constant: 0)
        addConstraints([left, top, right, bottom])
    }
    
    func addSuperviewUsingConstraints(superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(self)
        let views = ["view": self]
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                                options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                metrics: nil,
                                                                views: views))
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                                options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                metrics: nil,
                                                                views: views))
    }
}
