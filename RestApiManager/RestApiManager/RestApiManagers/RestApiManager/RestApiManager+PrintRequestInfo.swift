//
//  RestApiManager+PrintResponse.swift
//  FastTableViewDemo
//
//  Created by Panevnyk Vlad on 11/27/17.
//  Copyright © 2017 Panevnyk Vlad. All rights reserved.
//

import Foundation

// MARK: - Show request and responce info
public extension RestApiManager {
    func printDataResponse(_ dataResponse: URLResponse?, request: URLRequest?, data: Data?) {
        #if DEBUG
        if restApiManagerDIContainer.printRequestInfo {
            var printString = "\n\n-------------------------------------------------------------\n"
            
            if let urlDataResponse = dataResponse as? HTTPURLResponse {
                let statusCode = urlDataResponse.statusCode
                printString += "\(statusCode == 200 ? "SUCCESS" : "ERROR") \(statusCode)\n"
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
                    requestArray.append(["!!!<HEADERS>!!!": ["SYSTEM PRINT": "No Headers"]])
                }
                
                // PARAMETERS
                if let httpBody = request.httpBody {
                    do {
                        let temDictData = try JSONSerialization.jsonObject(with: httpBody, options: .allowFragments)
                        requestArray.append(["!!!<PARAMETERS>!!!": temDictData])
                    } catch {
                        requestArray.append(["!!!<PARAMETERS>!!!": ["SYSTEM PRINT": "Throw error: \(error)"]])
                    }
                }
                
                responceArray.append(["!!!<REQUEST>!!!": requestArray])
            } else {
                responceArray.append(["!!!<REQUEST>!!!": [["SYSTEM PRINT": "No Request"]]])
            }
            
            // RESPONSE
            do {
                if let data = data {
                    let temDictData = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    responceArray.append(["!!!<RESPONSE>!!!": temDictData])
                } else {
                    responceArray.append(["!!!<RESPONSE>!!!": ["SYSTEM PRINT": "No Data"]])
                }
                
            } catch {
                responceArray.append(["!!!<RESPONSE>!!!": ["SYSTEM PRINT": "Throw error: \(error)"]])
            }
            
            // Print
            do {
                var httpMethod = request?.httpMethod ?? ""
                if !httpMethod.isEmpty {
                    httpMethod += "\n"
                }
                
                let data = try JSONSerialization.data(withJSONObject: ["!!!<RESTAPIMANAGER>!!!": responceArray], options: .prettyPrinted)
                var responceString = String.init(data: data, encoding: .utf8) ?? ""
                responceString = responceString.replacingOccurrences(of: "\"!!!<RESTAPIMANAGER>!!!\" :", with: "")
                responceString = responceString.replacingOccurrences(of: "{\n   [\n    {\n      \"!!!<REQUEST>!!!\" : ", with: "\n\(httpMethod)REQUEST:")
                responceString = responceString.replacingOccurrences(of: "[\n        {\n          \"!!!<URL>!!!\" : ", with: "\n\tURL: \n\t\t  ")
                responceString = responceString.replacingOccurrences(of: "        },\n        {\n          \"!!!<HEADERS>!!!\" : ", with: "\tHEADERS: \n\t\t  ")
                responceString = responceString.replacingOccurrences(of: "\n        },\n        {\n          \"!!!<PARAMETERS>!!!\" : ", with: "\n\tPARAMETERS:\n\t\t  ")
                responceString = responceString.replacingOccurrences(of: "\n        }\n      ]\n    },\n    {\n      \"!!!<RESPONSE>!!!\" : ", with: "\nRESPONSE:\n\t  ")
                responceString = responceString.replacingOccurrences(of: "\\/", with: "/")
                if responceString.count > 12 {
                    responceString.removeLast(12) // "\n    }\n  ]\n}"
                }
                
                if responceString.isEmpty {
                    responceString = "Can't create string from responce"
                }
                
                printString += responceString + "\n"
            } catch {
                printString += "ERROR PRINTING RESPONCE\n"
            }
            
            printString += "-------------------------------------------------------------\n\n"
            
            print(printString)
        }
        #endif
    }
}
