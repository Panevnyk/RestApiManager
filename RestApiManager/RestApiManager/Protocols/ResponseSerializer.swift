//
//  ResponseSerializer.swift
//  Roadwarez
//
//  Created by Panevnyk Vlad on 10/31/17.
//  Copyright © 2017 Roadwarez. All rights reserved.
//

import Foundation

/// ResponseSerializer
public protocol ResponseSerializer {
    associatedtype SerializationType
    
    var completion: ((Result<SerializationType>) -> Void) { get set }
    
    init (completion: @escaping ((Result<SerializationType>) -> Void))
    func parse(method: RestApiMethod, response: HTTPURLResponse?, data: Data?, error: Error?)
}
