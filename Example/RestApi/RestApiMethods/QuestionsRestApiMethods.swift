//
//  QuestionsRestApiMethods.swift
//  Example
//
//  Created by Panevnyk Vlad on 11/16/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import RestApiManager

enum QuestionsRestApiMethods: RestApiMethod {
    // Method
    case getQuestions(QuestionsRestApiParameters)
    
    // URL
    private static let getQuestionsUrl = "questions"
    
    // RestApiData
    var data: RestApiData {
        switch self {
        case .getQuestions(let parameters):
            return RestApiData(url: RestApiConstants.baseURL + QuestionsRestApiMethods.getQuestionsUrl,
                               httpMethod: .get,
                               parameters: parameters,
                               keyPath: RestApiConstants.items)
        }
    }
}
