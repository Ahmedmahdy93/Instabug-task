//
//  MockMovieRepositoryListener.swift
//  Instabug-iOS-AssessmentTests
//
//  Created by ahmed mahdy on 12/24/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import Foundation
import XCTest
@testable import Instabug_iOS_Assessment

class MockMovieRepositoryListener:  MovieRepositoryListener{
    var expectation: XCTestExpectation?
    var calledViewForLoadData : Bool = false
    
    func onFinishLoadingMovies(movies: [Movie]?) {
        calledViewForLoadData = true
        expectation?.fulfill()
    }
    
    
}
