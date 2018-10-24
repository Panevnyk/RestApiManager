//
//  DefaultRestApiActivityIndicator.swift
//  Roadwarez
//
//  Created by Panevnyk Vlad on 3/23/17.
//  Copyright © 2017 Devlight company. All rights reserved.
//

import UIKit

/// DefaultRestApiActivityIndicator
public class DefaultRestApiActivityIndicator: RestApiActivityIndicator {
    /// RestApiActivityIndicatorView
    private weak var activityIndicatorView: RestApiActivityIndicatorView?
    
    /// Init
    public init() {}
    
    /// show
    public func show() {
        DispatchQueue.main.async { [unowned self] in
            self.hide()
            self.createRestApiActivityIndicatorView()
        }
    
    }

    /// show
    ///
    /// - Parameter view: onView
    public func show(onView view: UIView) {
        DispatchQueue.main.async { [unowned self] in
            self.hide()
            self.createRestApiActivityIndicatorView(onView: view)
        }
    }
    
    /// hide
    public func hide() {
        DispatchQueue.main.async { [unowned self] in
            if let activityIndicatorView = self.activityIndicatorView {
                activityIndicatorView.hide()
            }
        }
    }
    
    private func createRestApiActivityIndicatorView() {
        if let vc = UIApplication.presentationViewController {
            createRestApiActivityIndicatorView(onView: vc.view)
        }
    }
    
    private func createRestApiActivityIndicatorView(onView view: UIView) {
        let activityIndicatorView = RestApiActivityIndicatorView(frame: view.bounds)
        activityIndicatorView.addSuperviewUsingConstraints(superview: view)
        activityIndicatorView.setupView()
        activityIndicatorView.show()
        self.activityIndicatorView = activityIndicatorView
    }   
}
