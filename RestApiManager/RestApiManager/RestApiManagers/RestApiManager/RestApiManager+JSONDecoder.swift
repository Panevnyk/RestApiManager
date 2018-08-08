//
//  RestApiManager+JSONDecoder.swift
//  RestApiManager
//
//  Created by Panevnyk Vlad on 8/8/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import Foundation

extension RestApiManager {
    var jsonDecoder: JSONDecoder {
        return RestApiConfigurator.shared.jsonDecoder
    }
}
