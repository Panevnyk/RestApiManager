//
//  ViewController.swift
//  Example
//
//  Created by Panevnyk Vlad on 11/15/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import UIKit
import RestApiManager

final class ViewController: UIViewController {
    // RestApiManager
    private let restApiManager: RestApiManager =
        URLSessionRestApiManager(urlSessionRestApiManagerDIContainer:
            URLSessionRestApiManagerDIContainer(errorType: ExampleRestApiError.self,
                                                printRequestInfo: true))
    
    // Questions method and parameters
    private let questionsParameters = QuestionsRestApiParameters()
    private lazy var getQuestionsMethod: QuestionsRestApiMethods = .getQuestions(questionsParameters)
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
        simpleCallWithIndicatorAndErrorAlert()
    }
}

// MARK: - API call
private extension ViewController {
    func simpleCall() {
        restApiManager.call(method: getQuestionsMethod) { (result: Result<String>) in
            switch result {
            case .success:
                break
            case .failure:
                break
            }
        }
    }
    
    func simpleCallWithIndicatorAndErrorAlert() {
        restApiManager.call(method: getQuestionsMethod,
                            indicator: true,
                            errorAlert: true) { (result: Result<String>) in
            switch result {
            case .success:
                break
            case .failure:
                break
            }
        }
    }
}
