//
//  URLSessionRestApiManager+DataTask.swift
//  RestApiManager
//
//  Created by Panevnyk Vlad on 11/1/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import Foundation

// MARK: - DataTask with ResultWithET type responce
extension URLSessionRestApiManager {
    func createDataTaskWithET<T: Associated, ET: RestApiError>(method: RestApiMethod,
                                                               completion: @escaping (_ result: ResultWithET<T, ET>) -> Void) -> URLSessionTask? {
        return createDataTaskWithET(method: method, completion: completion) { [unowned self] (data) in
            self.decode(data: data, keyPath: method.data.keyPath, completion: completion)
        }
    }
    
    func createDataTaskWithET<T: Associated, ET: RestApiError>(method: RestApiMethod,
                                                               completion: @escaping (_ result: ResultWithET<T, ET>) -> Void,
                                                               completionHandler: @escaping (Data) -> Swift.Void) -> URLSessionTask? {
        return createDataTaskWithET(method: method, errorType: ET.self) { [unowned self] (data, urlResponse, error) in
            self.handleResponse(data: data, urlResponse: urlResponse, error: error, completion: completion, completionHandler: completionHandler)
        }
    }
    
    func createDataTaskWithET<ET: RestApiError>(method: RestApiMethod,
                                                errorType: ET.Type,
                                                completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionTask? {
        guard let request = request(method: method) else {
            completionHandler(nil, nil, ET.unknown)
            return nil
        }
        
        let dataTask = urlSessionRAMDIContainer
            .urlSession
            .dataTask(with: request) { [unowned self] (data, urlResponse, error) in
                
                // Print response
                self.printDataResponse(urlResponse, request: request, data: data)
                
                // Completion Handler
                completionHandler(data, urlResponse, error)
                
                // clearURLSessionTask
                self.clearURLSessionTask()
        }
        dataTask.resume()
        
        appendURLSessionTask(dataTask)
        
        return dataTask
    }
}

// MARK: - MultipartDataTask with ResultWithET type responce
extension URLSessionRestApiManager {
    func createMultipartDataTaskWithET<T: Associated, ET: RestApiError>(multipartData: MultipartData,
                                                                        method: RestApiMethod,
                                                                        completion: @escaping (_ result: ResultWithET<T, ET>) -> Void) -> URLSessionTask? {
        return createMultipartDataTaskWithET(multipartData: multipartData, method: method, completion: completion) { [unowned self] (data) in
            self.decode(data: data, keyPath: method.data.keyPath, completion: completion)
        }
    }
    
    func createMultipartDataTaskWithET<T: Associated, ET: RestApiError>(multipartData: MultipartData,
                                                                        method: RestApiMethod,
                                                                        completion: @escaping (_ result: ResultWithET<T, ET>) -> Void,
                                                                        completionHandler: @escaping (Data) -> Swift.Void) -> URLSessionTask? {
        return createMultipartDataTaskWithET(multipartData: multipartData,
                                             method: method,
                                             errorType: ET.self) { [unowned self] (data, urlResponse, error) in
                                                self.handleResponse(data: data, urlResponse: urlResponse, error: error, completion: completion, completionHandler: completionHandler)
        }
    }
    
    func createMultipartDataTaskWithET<ET: RestApiError>(multipartData: MultipartData,
                                                         method: RestApiMethod,
                                                         errorType: ET.Type,
                                                         completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionTask? {
        guard let request = request(method: method) else {
            completionHandler(nil, nil, ET.unknown)
            return nil
        }
        
        let dataTask = urlSessionRAMDIContainer
            .urlSession
            .uploadTask(with: request, from: multipartData.data) { [unowned self] (data, urlResponse, error) in
                
                // Print response
                self.printDataResponse(urlResponse, request: request, data: data)
                
                // Completion Handler
                completionHandler(data, urlResponse, error)
                
                // clearURLSessionTask
                self.clearURLSessionTask()
        }
        dataTask.resume()
        
        appendURLSessionTask(dataTask)
        
        return dataTask
    }
}

// MARK: - Work URLSessionTask
extension URLSessionRestApiManager {
    func appendURLSessionTask(_ dataTask: URLSessionTask) {
        currentURLSessionTasks.append(dataTask)
    }
    
    func clearURLSessionTask() {
        var offset = 0
        for (index, currentDataTask) in currentURLSessionTasks.enumerated() {
            if currentDataTask.state == .canceling || currentDataTask.state == .completed {
                currentURLSessionTasks.remove(at: index - offset)
                offset += 1
            }
        }
    }
}
