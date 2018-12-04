//
//  DefaultRestApiAlert.swift
//  FastTableViewDemo
//
//  Created by Panevnyk Vlad on 11/6/17.
//  Copyright © 2017 Panevnyk Vlad. All rights reserved.
//

import UIKit

/// DefaultRestApiAlert
public class DefaultRestApiAlert: RestApiAlert {
    /// Queue
    private let queue = OperationQueue()
    private let semaphore = DispatchSemaphore(value: 1)
    
    /// init
    public init() {
        queue.maxConcurrentOperationCount = 1
    }
    
    /// show
    ///
    /// - Parameter error: RestApiError
    public func show(error: RestApiError) {
        show(title: "Error", message: error.details, completion: nil)
    }
    
    /// show
    ///
    /// - Parameters:
    ///   - title: title of UIAlertController
    ///   - message: message of UIAlertController
    ///   - completion: completion of UIAlertController
    public func show(title: String, message: String, completion: (() -> Void)?) {
        let operation = BlockOperation()
        operation.addExecutionBlock {
            self.semaphore.wait()
            if operation.isCancelled {
                print("!!!!!!!!!!!")
                print("isCancelled")
                print("!!!!!!!!!!!")
                self.semaphore.signal()
                return
            }
            OperationQueue.main.addOperation({
                guard let rootViewController = UIApplication.presentationViewController else {
                    self.semaphore.signal()
                    return
                }
                
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: { [unowned self] _ in
                    completion?()
                    self.semaphore.signal()
                })
                alert.addAction(okAction)
                rootViewController.present(alert, animated: true, completion: nil)
                
            })
        }
        queue.addOperation(operation)
    }
}
