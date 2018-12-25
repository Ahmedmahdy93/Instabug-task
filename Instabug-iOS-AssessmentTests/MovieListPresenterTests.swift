//
//  MovieListPresenterTests.swift
//  Instabug-iOS-AssessmentTests
//
//  Created by ahmed mahdy on 12/24/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import XCTest
@testable import Instabug_iOS_Assessment

class MovieListPresenterTests: XCTestCase {
    let presenter = MovieListPresenter()
//    let delegate = MockMovieRepositoryListener()

    override func setUp() {
        presenter.providerInstance = MockMovieRepository()
        presenter.setDelegate(view: presenter)
    }
    func testLoadMovies() {
        
        presenter.loadMoview()
        
        XCTAssert(presenter.dataSource != nil)

    }
    func testLoadMore(){
        let indexPath = IndexPath(row: 4, section: 0)
        presenter.providerInstance = MockMovieRepository()
        presenter.loadMoview()
        
        let canLoadMorePages = presenter.canLoadMore(indexPath: indexPath)
        XCTAssert(!canLoadMorePages)
    }
    
}
