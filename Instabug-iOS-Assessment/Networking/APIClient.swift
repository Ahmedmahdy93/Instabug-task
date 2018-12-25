//
//  APIClient.swift
//  Instabug-iOS-Assessment
//
//  Created by ahmed mahdy on 12/21/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import Foundation
enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}

protocol APIClient {
    var session: URLSession { get }
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void)
}
extension APIClient {
    typealias JSONTaskCompletionHandler = (Result<Decodable, APIError>) -> Void
    private func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed))
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
//                    do {
//                        let genericModel = try JSONDecoder().decode(decodingType, from: data)
//                        completion(.success(genericModel))
//                    } catch {
//                        completion(.failure(.jsonConversionFailure))
//                    }
                    self.decodeJsonResponse(decodingType: decodingType, jsonObject: data, completion: completion)
                } else {
                    completion(.failure(.invalidData))
                }
            } else {
                completion(.failure(.responseUnsuccessful))
            }
        }
        return task
    }
    func decodeJsonResponse<T: Decodable>(decodingType:T.Type,jsonObject: Data, completion: @escaping JSONTaskCompletionHandler){
        do {
            let genericModel = try JSONDecoder().decode(decodingType, from: jsonObject)
            completion(.success(genericModel))
        } catch {
            completion(.failure(.jsonConversionFailure))
        }
    }
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        let task = decodingTask(with: request, decodingType: T.self) { result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let value = decode(json) {
                        completion(.success(value))
                    } else {
                        completion(.failure(.jsonParsingFailure))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
