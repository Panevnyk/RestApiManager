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
            print("\n\n-------------------------------------------------------------")
            if let urlDataResponse = dataResponse as? HTTPURLResponse {
                let statusCode = urlDataResponse.statusCode
                print("\(statusCode == 200 ? "SUCCESS" : "ERROR") \(statusCode)")
            }
            
            var responceArray: [[String: Any]] = []
            // REQUEST
            if let request = request {
                var requestArray: [[String: Any]] = []
                
                // URL
                requestArray.append(["!!!<URL>!!!": request.url?.absoluteString ?? ""])
                
                // HEADERS
                if let headers = request.allHTTPHeaderFields {
                    requestArray.append(["!!!<HEADERS>!!!": headers])
                } else {
                    requestArray.append(["!!!<HEADERS>!!!": "No Headers"])
                }
                
                // PARAMETERS
                if let httpBody = request.httpBody {
                    do {
                        let temDictData = try JSONSerialization.jsonObject(with: httpBody, options: .allowFragments)
                        requestArray.append(["!!!<PARAMETERS>!!!": temDictData])
                    } catch {
                        requestArray.append(["!!!<PARAMETERS>!!!": "Throw error: \(error)"])
                    }
                } else {
                    requestArray.append(["!!!<PARAMETERS>!!!": "No Parameters"])
                }
                
                responceArray.append(["!!!<REQUEST>!!!": requestArray])
            } else {
                responceArray.append(["!!!<REQUEST>!!!": "No Request"])
            }
            
            // RESPONSE
            do {
                if let data = data {
                    let temDictData = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    responceArray.append(["!!!<RESPONSE>!!!": temDictData])
                } else {
                    responceArray.append(["!!!<RESPONSE>!!!": "No Data"])
                }
                
            } catch {
                responceArray.append(["!!!<RESPONSE>!!!": "Throw error: \(error)"])
            }
            
            // Print
            do {
                
                let data = try JSONSerialization.data(withJSONObject: ["!!!<RESTAPIMANAGER>!!!": responceArray], options: .prettyPrinted)
                var responceString = String.init(data: data, encoding: .utf8) ?? ""
                responceString = responceString.replacingOccurrences(of: "\"!!!<RESTAPIMANAGER>!!!\" :", with: "")
                responceString = responceString.replacingOccurrences(of: "\"!!!<REQUEST>!!!\" :", with: "REQUEST: \n\t\t\t")
                responceString = responceString.replacingOccurrences(of: "\"!!!<URL>!!!\" :", with: "URL: \n\t\t\t")
                responceString = responceString.replacingOccurrences(of: "\"!!!<HEADERS>!!!\" :", with: "HEADERS: \n\t\t\t")
                responceString = responceString.replacingOccurrences(of: "\"!!!<PARAMETERS>!!!\" :", with: "PARAMETERS: \n\t\t\t")
                responceString = responceString.replacingOccurrences(of: "\"!!!<RESPONSE>!!!\" :", with: "RESPONSE: \n\t\t\t")
                
                if responceString.isEmpty {
                    responceString = "Can't create string from responce"
                }
                
                print(responceString)
            } catch {
                print("ERROR PRINTING RESPONCE")
            }
            
            print("-------------------------------------------------------------\n\n")
        }
        #endif
    }
}
