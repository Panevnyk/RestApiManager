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
        guard let nib = loadOwnNib() else {
            return
        }
        addSubviewUsingConstraints(view: nib)
        initialize()
    }
    
    func loadOwnNib() -> UIView? {
        let nibName = String(describing: type(of: self))
        if let nibFiles = Bundle(identifier: "panevnyk.RestApiManager")?.loadNibNamed(nibName, owner: self, options: nil),
            nibFiles.count > 0 {
            return nibFiles.first as? UIView
        }
        return nil
    }
    
    /// initialize base UI
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
