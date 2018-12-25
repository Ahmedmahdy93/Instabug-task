//
//  MockMovieClient.swift
//  Instabug-iOS-AssessmentTests
//
//  Created by ahmed mahdy on 12/24/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import Foundation
@testable import Instabug_iOS_Assessment

class MockGetMoviesNetworkProvider: MovieClient {
    override func discover(page: Int, completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        let client = MovieClient()
        let bundle = Bundle(for: type(of: self))
        if let path = bundle.path(forResource: "JsonDataExamble", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                client.decodeJsonResponse(decodingType: MovieResult.self, jsonObject: data) { (result) in
                        switch result {
                        case .success(let json):
                            if let value = json as? MovieResult {
                                completion(.success(value))
                            } else {
                                completion(.failure(.jsonParsingFailure))
                            }
                        case .failure(let error):
                            completion(.failure(error))
                        }
                }
            } catch {
                completion(.failure(.invalidData))
            }
        }
    }
    
}
