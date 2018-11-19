//
//  PostOwner.swift
//  Example
//
//  Created by Panevnyk Vlad on 11/19/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import Foundation

struct PostOwner: Decodable {
    var acceptRate = 0
    var link = ""
    var userId = 0
    var displayName = ""
    var reputation = 0
    
    enum CodingKeys: String, CodingKey {
        case acceptRate = "accept_rate"
        case link
        case userId = "user_id"
        case displayName = "display_name"
        case reputation
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        acceptRate = (try? container.decode(Int.self, forKey: .acceptRate)) ?? 0
        link = (try? container.decode(String.self, forKey: .link)) ?? ""
        userId = (try? container.decode(Int.self, forKey: .userId)) ?? 0
        displayName = (try? container.decode(String.self, forKey: .displayName)) ?? ""
        reputation = (try? container.decode(Int.self, forKey: .reputation)) ?? 0
    }
}
