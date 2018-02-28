//
//  RestApiActivityIndicatorView.swift
//  Roadwarez
//
//  Created by Panevnyk Vlad on 3/23/17.
//  Copyright © 2017 Devlight company. All rights reserved.
//

import UIKit

/// RestApiActivityIndicatorView
public class RestApiActivityIndicatorView: UIView, RestApiDetailAnimable {
    /// UI
    @IBOutlet private var xibView: UIView!
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!

    /// init
    ///
    /// - Parameter frame: CGRect
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    /// init
    ///
    /// - Parameter aDecoder: NSCoder
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// setupView
    public func setupView() {
        addSelfNibUsingConstraints()
        initialize()
    }
    
    private func initialize() {
        alpha = 0
        contentView.layer.cornerRadius = 5
        contentView.backgroundColor = UIColor.gray
    }
    
    /// Show activityIndicator
    public func show() {
        showView()
        activityIndicator.startAnimating()
    }
    
    /// Hide activityIndicator
    public func hide() {
        hideView { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.removeFromSuperview()
        }
    }
    
}
