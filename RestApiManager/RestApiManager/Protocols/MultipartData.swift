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
    var boundary: String { get set }
    var parameters: [String: String]? { get set }
    var multipartObjects: [MultipartObject]? { get set }
}

/// MultipartObject
public struct MultipartObject {
    public var key: String
    public var data: Data
    public var mimeType: String
    public var filename: String
    
    public init(key: String,
                data: Data,
                mimeType: String,
                filename: String) {
        self.key = key
        self.data = data
        self.mimeType = mimeType
        self.filename = filename
    }
}

/// MultipartData extension for generate final data
public extension MultipartData {
    var data: Data {
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = parameters {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }
        }
        
        if let multipartObjects = multipartObjects {
            for multipartObject in multipartObjects {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(multipartObject.key)\"; filename=\"\(multipartObject.filename)\"\(lineBreak)")
                body.append("Content-Type: \(multipartObject.mimeType + lineBreak + lineBreak)")
                body.append(multipartObject.data)
                body.append(lineBreak)
            }
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
}

/// Data extension for append string
extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
