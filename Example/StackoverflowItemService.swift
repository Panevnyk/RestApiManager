//
//  StackoverflowItemService.swift
//  Example
//
//  Created by Panevnyk Vlad on 11/19/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import RestApiManager

final class StackoverflowItemService {
    // RestApiManager
    private let restApiManager: RestApiManager =
        URLSessionRestApiManager(urlSessionRestApiManagerDIContainer:
            URLSessionRestApiManagerDIContainer(errorType: ExampleRestApiError.self,
                                                printRequestInfo: true))
    
    // Questions method and parameters
    private let questionsParameters = QuestionsRestApiParameters()
    private lazy var getQuestionsMethod: QuestionsRestApiMethods = .getQuestions(questionsParameters)
}

// MARK: - API call
extension StackoverflowItemService {
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
    
    /// Call method that parse response to [StackoverflowItemModel] Array in success case.
    /// Automaticaly show and hide Indicator View (from URLSessionRestApiManagerDIContainer).
    /// Automaticaly show Error Alert in failure case (from URLSessionRestApiManagerDIContainer).
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
}
