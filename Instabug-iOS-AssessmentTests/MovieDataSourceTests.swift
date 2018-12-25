//
//  MovieDataSourceTests.swift
//  Instabug-iOS-AssessmentTests
//
//  Created by ahmed mahdy on 12/25/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import XCTest
@testable import Instabug_iOS_Assessment

class MovieDataSourceTests: XCTestCase {
    
    class singltonStub: MovieDataSource {
        
    }
    let dataSourceInstance = singltonStub.instance
    override func setUp() {
        singltonStub.instance.myMovies = nil
    }
    
    func testAddMovie() {
        
        let movie = Movie(title: "first movie", overview: "over view", release_date: "12-10-2013", poster_path: "//someURL")
        dataSourceInstance.addNewMovie(movie: movie)
        XCTAssert(dataSourceInstance.myMovies != nil)
    }
    func testloadFromPageFail() {
        var MoviesInPage : [Movie]?
        dataSourceInstance.loadDataFromPage(page: 1) { (result) in
            MoviesInPage = result?.results
        }
        XCTAssert(MoviesInPage == nil)
    }
    func testLoadMoviesFromPage() {
        for i in 1...10{
            let movie = Movie(title: "movie \(i)", overview: "over view \(i)", release_date: "12-10-2013\(i)", poster_path: "//someURL\(i)")
            dataSourceInstance.addNewMovie(movie: movie)
        }
        var MoviesInPage : [Movie]?
        dataSourceInstance.loadDataFromPage(page: 1) { (result) in
            MoviesInPage = result?.results
        }
        XCTAssert(MoviesInPage?.count == 6)
        dataSourceInstance.loadDataFromPage(page: 2) { (result) in
            MoviesInPage = result?.results
        }
        XCTAssert(MoviesInPage?.count == (dataSourceInstance.myMovies?.count)! - 6)
    }
    

}
