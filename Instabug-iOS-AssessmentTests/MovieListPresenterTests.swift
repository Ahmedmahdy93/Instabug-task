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
    let delegate = MockMovieRepositoryListener()

    override func setUp() {
        presenter.providerInstance = MockMovieRepository()
        presenter.setDelegate(view: delegate)
    }
    func testLoadMovies() {
        
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
    func testLoadImage() {
        presenter.loadMoview()
        guard let  dataSource = presenter.dataSource else {
            return
        }
        let firstMovieURL = posterUrl(movie: dataSource[0], localImage: false)
        var image: UIImageView?
        
        image!.load(url: firstMovieURL)
        XCTAssert(image != nil)
    }
}
