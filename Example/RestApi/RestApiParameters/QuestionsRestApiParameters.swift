//
//  RestApiParameters.swift
//  Example
//
//  Created by Panevnyk Vlad on 11/16/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import RestApiManager

struct QuestionsRestApiParameters: ParametersProtocol {
    let order = "desc"
    let sort = "votes"
    let site = "stackoverflow"
    
    var parametersValue: Parameters {
        let parameters: [String: Any] = [
            RestApiConstants.order: order,
            RestApiConstants.sort: sort,
            RestApiConstants.site: site
        ]
        
        return parameters
    }
}
