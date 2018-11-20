//
//  StackoverflowResponseSerializer.swift
//  Example
//
//  Created by Panevnyk Vlad on 11/20/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import RestApiManager

final class StackoverflowResponseSerializer: ResponseSerializer {
    typealias SerializationType = (items: [StackoverflowItemModel], hasMore: Bool, quotaMax: Int, quotaRemaining: Int)

    var completion: ((Result<SerializationType>) -> Void)
    
    required init (completion: @escaping ((Result<SerializationType>) -> Void)) {
        self.completion = completion
    }

    func parse(method: RestApiMethod, response: HTTPURLResponse?, data: Data?, error: Error?) {
        guard let data = data else {
            completion(.failure(DefaultRestApiError.noData))
            return
        }

        do {
            let items: [StackoverflowItemModel] = try JSONDecoder().decode([StackoverflowItemModel].self, from: data, keyPath: RestApiConstants.items)
            let hasMore: Bool = try JSONDecoder().decode(Bool.self, from: data, keyPath: RestApiConstants.hasMore)
            let quotaMax: Int = try JSONDecoder().decode(Int.self, from: data, keyPath: RestApiConstants.quotaMax)
            let quotaRemaining: Int = try JSONDecoder().decode(Int.self, from: data, keyPath: RestApiConstants.quotaRemaining)
            
            completion(.success((items: items, hasMore: hasMore, quotaMax: quotaMax, quotaRemaining: quotaRemaining)))
        } catch {
            completion(.failure(DefaultRestApiError.noData))
        }
    }
}
