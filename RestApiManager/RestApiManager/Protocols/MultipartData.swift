//
//  MultipartData.swift
//  Roadwarez
//
//  Created by Panevnyk Vlad on 10/27/17.
//  Copyright © 2017 Roadwarez. All rights reserved.
//

import Foundation

/// MultipartData
public protocol MultipartData {
    var data: Data { get set }
    var name: String { get set }
    var fileName: String { get set }
    var mimeType: String { get set }
}
