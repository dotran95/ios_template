//
//  ApiClient.swift
//  app
//
//  Created by dotn on 24/07/2024.
//

import Foundation

protocol ApiClientTask {
    func cancel()
}

protocol ApiClient {
    func execute<T>(endpoint: EndPoint, type: T.Type, completionHandler: @escaping (_ result: Result<ApiResponse<T>, Error>) -> Void) -> ApiClientTask?
    func execute<T>(endpoint: EndPoint, type: T.Type) async throws -> Result<ApiResponse<T>, Error>
}

class ApiClientImplementation: ApiClient {
    private let urlSession: URLSession
    
    init(urlSessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default, completionHandlerQueue: OperationQueue = OperationQueue.main) {
        urlSession = URLSession(configuration: urlSessionConfiguration, delegate: nil, delegateQueue: completionHandlerQueue)
    }
    
    // MARK: - ApiClient
    
    func execute<T>(endpoint: EndPoint, type: T.Type, completionHandler: @escaping (Result<ApiResponse<T>, Error>) -> Void) -> ApiClientTask? {
        do {
            let request = try endpoint.request
            let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
                
                // Add Log API
                request.debugLog()
                response?.debugLog(data: data, error: error)
                
                guard let httpUrlResponse = response as? HTTPURLResponse else {
                    completionHandler(.failure(NetworkRequestError()))
                    return
                }
                
                let successRange = 200...299
                
                // Case call api Successful
                if successRange.contains(httpUrlResponse.statusCode) {
                    do {
                        let result = try ApiResponse<T>(type, data: data, httpUrlResponse: httpUrlResponse)
                        completionHandler(.success(result))
                    } catch {
                        completionHandler(.failure(error))
                    }
                } else {
                    // Case call api Failure
                    completionHandler(.failure(ApiError(statusCode: httpUrlResponse.statusCode)))
                }
            }
            
            dataTask.resume()
            return URLSessionTaskWrapper(wrapped: dataTask)
        } catch let requestErro {
            
            // maybe create URLRequest failure
            completionHandler(.failure(requestErro))
            return nil
        }
    }
    
    func execute<T>(endpoint: any EndPoint, type: T.Type) async throws -> Result<ApiResponse<T>, any Error> where T : Decodable {
        do {
            let request = try endpoint.request
            let (data, response) = try await urlSession.data(for: request)
            
            // Add Log API
            request.debugLog()
            response.debugLog(data: data, error: nil)

            
            guard let httpUrlResponse = response as? HTTPURLResponse else {
                return .failure(NetworkRequestError())
            }
            
            let successRange = 200...299
            if successRange.contains(httpUrlResponse.statusCode) {
                do {
                    let result = try ApiResponse<T>(type, data: data, httpUrlResponse: httpUrlResponse)
                    return .success(result)
                } catch let parseErr {
                    return .failure(parseErr)
                }
            } else {
                return .failure(ApiError(statusCode: httpUrlResponse.statusCode))
            }
        } catch let requestErro {
            return.failure(requestErro)
        }
    }
}

extension ApiClientImplementation {
    struct URLSessionTaskWrapper: ApiClientTask {
        let wrapped: URLSessionTask
        
        func cancel() {
            wrapped.cancel()
        }
    }
}
