//
//  CreateMoviePresenter.swift
//  Instabug-iOS-AssessmentTests
//
//  Created by ahmed mahdy on 12/25/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import XCTest
@testable import Instabug_iOS_Assessment

class CreateMoviePresenterTest: XCTestCase {

    let dataSourceInstance = MovieDataSource.instance
    let createPresenter = CreateMoviePresenter()
    override func setUp() {
        
    }

    func testAddMovies() {
        createPresenter.setNewMovie(movie: Movie(title: "added from Presenter", overview: "added", release_date: "10-11-2019", poster_path: "//data"), type: .MyMovies)
        XCTAssert(dataSourceInstance.myMovies?.last?.title == "added from Presenter")
    }

}
