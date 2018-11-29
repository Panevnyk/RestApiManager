//
//  ViewController.swift
//  Example
//
//  Created by Panevnyk Vlad on 11/15/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    let stackoverflowItemService = StackoverflowItemService()
}

// MARK: - Life cycle
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Actions
private extension ViewController {
    @IBAction func sendAction(_ sender: Any) {
        // Do some API method call
        stackoverflowItemService
            .simpleCallWithIndicatorAndErrorAlert()
    }
}
