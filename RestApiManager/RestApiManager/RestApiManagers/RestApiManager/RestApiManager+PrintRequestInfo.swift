//
//  RestApiManager+PrintResponse.swift
//  FastTableViewDemo
//
//  Created by Panevnyk Vlad on 11/27/17.
//  Copyright © 2017 Panevnyk Vlad. All rights reserved.
//

import Foundation

// MARK: - Show request and responce info
extension RestApiManager {
    var printRequestInfo: Bool {
        return RestApiConfigurator.shared.printRequestInfo
    }
    
    func printDataResponse(_ dataResponse: URLResponse?, request: URLRequest?, data: Data?) {
        if printRequestInfo {
            if let urlDataResponse = dataResponse as? HTTPURLResponse {
                let statusCode = urlDataResponse.statusCode
                print("\n\n-------------------------------------------------------------")
                print("\(statusCode == 200 ? "SUCCESS" : "ERROR") \(statusCode)")
                print("\theaders: \(urlDataResponse.allHeaderFields)")
            }
            if let request = request {
                print("REQUEST:\n\t\(request)")
                if let headers = request.allHTTPHeaderFields {
                    print("\tHeaders: \(headers)")
                }
                if let httpBody = request.httpBody,
                    let parameters = String(data: httpBody, encoding: .utf8) {
                    print("\tParameters: \(parameters)")
                }
            }
            do {
                if let data = data {
                    print("RESPONSE:\n\(try JSONSerialization.jsonObject(with: data, options: .allowFragments))")
                } else {
                    print("RESPONSE:\n\tNo Data")
                }
            } catch let error {
                print("RESPONSE:\n\tThrow error: \(error)")
            }
            print("-------------------------------------------------------------\n\n")
        }
    }
}

