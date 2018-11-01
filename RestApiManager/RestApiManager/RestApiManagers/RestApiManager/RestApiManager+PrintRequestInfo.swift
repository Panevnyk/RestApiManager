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
        if restApiManagerDIContainer.printRequestInfo {
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
                        let tmpDictData = try JSONSerialization.jsonObject(with: httpBody, options: .allowFragments)
                        let dictData = ["Parameters": tmpDictData]
                        
                        let data = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
                        
                        if let responceString = String.init(data: data, encoding: .utf8) {
                            print("\t\(responceString)")
                        } else {
                            print("\tParameters: No Parameters")
                        }
                    } catch {
                        print("\tParameters: Throw error: \(error)")
                    }
                }
            }
            do {
                if let data = data {
                    let dictData = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let serializedData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
                    if let responceString = String(data: serializedData, encoding: .utf8) {
                        print("\nRESPONSE:\n\(responceString)")
                    } else {
                        print("\nRESPONSE:\n\tCan't create string from data")
                    }
                } else {
                    print("\nRESPONSE:\n\tNo Data")
                }
                
            } catch {
                print("\nRESPONSE:\n\tThrow error: \(error)")
            }
            print("-------------------------------------------------------------\n\n")
        }
        #endif
    }
}
