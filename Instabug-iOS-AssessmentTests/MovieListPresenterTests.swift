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
    
    func testLoadMovies() {
        let presenter = MovieListPresenter()
        presenter.providerInstance = MockMovieRepository()
        let delegate = MockMovieRepositoryListener()
        presenter.setDelegate(view: delegate)
        
        let expectation = XCTestExpectation(description: "loadMoviesInformationExpectation")
        presenter.loadMoview()
        delegate.expectation = expectation
        
        XCTAssert(delegate.calledViewForLoadData == true)

    }
    func testLoadMore(){
        let indexPath = IndexPath(row: 4, section: 0)
        let presenter = MovieListPresenter()
        presenter.providerInstance = MockMovieRepository()
        let delegate = MockMovieRepositoryListener()
        presenter.setDelegate(view: delegate)
        presenter.loadMoview()
        
        let canLoadMorePages = presenter.canLoadMore(indexPath: indexPath)
        XCTAssert(!canLoadMorePages)
    }
//    func testAddMovie(){
//        let createPresenter = CreateMoviePresenter()
//        let presenter = MovieListPresenter()
//        presenter.providerInstance = MovieInMemoryRepository()
//        let delegate = MockMovieRepositoryListener()
//        presenter.setDelegate(view: delegate)
//        presenter.loadMoview()
//        
//        XCTAssert()
//    }
}
