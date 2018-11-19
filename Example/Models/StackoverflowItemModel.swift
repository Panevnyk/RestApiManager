//
//  StackoverflowItemModel.swift
//  Example
//
//  Created by Panevnyk Vlad on 11/19/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import Foundation

struct StackoverflowItemModel: Decodable {
    var answerCount = 0
    var lastEditDate: Date?
    var owner: PostOwner?
    var protectedDate: Date?
    var link = ""
    var tags: [String] = []
    
    enum CodingKeys: String, CodingKey {
        case answerCount = "answer_count"
        case lastEditDate = "last_edit_date"
        case owner
        case protectedDate = "protected_date"
        case link
        case tags
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        answerCount = (try? container.decode(Int.self, forKey: .answerCount)) ?? 0
        lastEditDate = try? container.decode(Date.self, forKey: .lastEditDate)
        owner = try? container.decode(PostOwner.self, forKey: .owner)
        protectedDate = try? container.decode(Date.self, forKey: .protectedDate)
        link = (try? container.decode(String.self, forKey: .link)) ?? ""
        tags = (try? container.decode([String].self, forKey: .tags)) ?? []
    }
}
