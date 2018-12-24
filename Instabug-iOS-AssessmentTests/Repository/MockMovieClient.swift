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
        completion(.success(TestHelper.movieInformation))

    }
    
}
