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
    public func printDataResponse(_ dataResponse: URLResponse?, request: URLRequest?, data: Data?) {
        #if DEBUG
        if restApiManagerDIFabric.printRequestInfo {
            if let urlDataResponse = dataResponse as? HTTPURLResponse {
                let statusCode = urlDataResponse.statusCode
                print("\n\n-------------------------------------------------------------")
                print("\(statusCode == 200 ? "SUCCESS" : "ERROR") \(statusCode)")
            }
            if let request = request {
                print("\nREQUEST:\n\t\(request)")
                if let headers = request.allHTTPHeaderFields {
                    print("\tHeaders: \(headers)")
                }
                if let httpBody = request.httpBody {
                    do {
                        print("\tParameters: \(try JSONSerialization.jsonObject(with: httpBody, options: .allowFragments))")
                    } catch let error {
                        print("\tParameters: Throw error: \(error)")
                    }
                }
            }
            do {
                if let data = data {
                    print("\nRESPONSE:\n\(try JSONSerialization.jsonObject(with: data, options: .allowFragments))")
                } else {
                    print("\nRESPONSE:\n\tNo Data")
                }
            } catch let error {
                print("\nRESPONSE:\n\tThrow error: \(error)")
            }
            print("-------------------------------------------------------------\n\n")
        }
        #endif
    }
}

