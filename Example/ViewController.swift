//
//  ViewController.swift
//  Example
//
//  Created by Panevnyk Vlad on 11/15/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import RestApiManager

final class ViewController: UIViewController {
    // RestApiManager
    private let restApiManager: RestApiManager =
        URLSessionRestApiManager(urlSessionRAMDIContainer:
            URLSessionRAMDIContainer(errorType: ExampleRestApiError.self,
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
extension ViewController {
    // MARK: - Array response call
    /// Call method that parse response to [StackoverflowItemModel] Array in success case
    func simpleCall() {
        restApiManager.call(method: getQuestionsMethod) { (result: Result<[StackoverflowItemModel]>) in
            switch result {
            case .success(let obj):
                print("!!! obj: \(obj)")
            case .failure(let error):
                print("!!! error: \(error)")
            }
        }
    }
    
    // MARK: - Array only success response call
    /// Call method that parse response to [StackoverflowItemModel] Array in success case.
    /// If method will be failed, completion doesn't call
    func simpleCallWithSuccessResponse() {
        restApiManager.call(method: getQuestionsMethod) { (objects: [StackoverflowItemModel]) in
            print("!!! objects: \(objects)")
        }
    }
    
    // MARK: - String response call
    /// Call method that parse response to String in success case
    func simpleCallWithStringResponse() {
        restApiManager.call(method: getQuestionsMethod) { (result: Result<String>) in
            switch result {
            case .success(let obj):
                print("!!! obj: \(obj)")
            case .failure(let error):
                print("!!! error: \(error)")
            }
        }
    }
    
    // MARK: - Call with autoshow indicator and errorAlert
    /// Call method that parse response to [StackoverflowItemModel] Array in success case.
    /// Automaticaly show and hide Indicator View (from URLSessionRAMDIContainer).
    /// Automaticaly show Error Alert in failure case (from URLSessionRAMDIContainer).
    func simpleCallWithIndicatorAndErrorAlert() {
        restApiManager.call(method: getQuestionsMethod, indicator: true, errorAlert: true) { (result: Result<[StackoverflowItemModel]>) in
            switch result {
            case .success(let obj):
                print("!!! obj: \(obj)")
            case .failure(let error):
                print("!!! error: \(error)")
            }
        }
    }
    
    // MARK: - Call with custom Error class
    /// Call method that work with custom AlwaysFailureRestApiError Error class.
    /// Handle method of AlwaysFailureRestApiError class always return instance.
    /// As a result this method always will be failed
    func callWithAlwaysFailureRestApiError() {
        restApiManager.call(method: getQuestionsMethod) { (result: ResultWithET<[StackoverflowItemModel], AlwaysFailureRestApiError>) in
            switch result {
            case .success(let obj):
                print("!!! obj: \(obj)")
            case .failure(let error):
                print("!!! error: \(error)")
            }
        }
    }
    
    // MARK: - Call with CustomResponseSerializer
    /// Call method with CustomResponseSerializer.
    /// Return closure with Array, Bool, Int, Int
    func callWithCustomResponseSerializer() {
        let responseSerializer = StackoverflowResponseSerializer { (result: Result<StackoverflowResponseSerializer.SerializationType>) in
            switch result {
            case .success(let obj):
                print("!!! obj.items: \(obj.items)")
                print("!!! obj.hasMore: \(obj.hasMore)")
                print("!!! obj.quotaMax: \(obj.quotaMax)")
                print("!!! obj.quotaRemaining: \(obj.quotaRemaining)")
            case .failure(let error):
                print("!!! error: \(error)")
            }
        }
        restApiManager.call(method: getQuestionsMethod, responseSerializer: responseSerializer)
    }
}

