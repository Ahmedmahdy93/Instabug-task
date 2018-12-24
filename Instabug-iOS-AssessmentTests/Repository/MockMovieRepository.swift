//
//  MockMovieRepository.swift
//  Instabug-iOS-AssessmentTests
//
//  Created by ahmed mahdy on 12/24/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import Foundation
@testable import Instabug_iOS_Assessment

class MockMovieRepository:MovieRepository  {
    
    var delegate: MovieRepositoryListener?
    var isLoading = false
    var currentPage = 0
    var lastMovieResult: MovieResult?
    var movies: [Movie]?
    
    func loadDataFromPage(page: Int) {
        if self.isLoading { return }
        self.isLoading = true
        
        MockGetMoviesNetworkProvider().discover(page: page) {[weak self] (result) in
            switch result {
            case .success(let movieResult) :
                self?.setMovieResult(newList: movieResult!)
                self?.currentPage = page
            case .failure(let error) :
                print("error \(error)")
            }
            self?.isLoading = false
        }
    }
    
    func addNewMovie(movie: Movie) {
        
    }
    
    func setDelegat(view: MovieRepositoryListener) {
        self.delegate = view
    }
    
    func setMovieResult(newList: MovieResult?) {
        self.lastMovieResult = newList
        if self.movies == nil {
            self.movies = newList?.results
        }else{
            if let newMovies = newList?.results{
                self.movies?.append(contentsOf: newMovies)
            }
        }
        self.delegate?.onFinishLoadingMovies(movies: self.movies)
    }
    
    func canLoadMore(indexPath: IndexPath) -> Bool {
        if let movies = self.movies {
            let lastRow = movies.count - 1
            if indexPath.row == lastRow && self.lastMovieResult!.page < self.lastMovieResult!.total_pages {
                return true
            }
        }
        return false
    }
    
    func loadMovies() {
        if self.lastMovieResult == nil {
            self.loadDataFromPage(page: 1)
        }
    }
    
    func loadNextPage() {
        loadDataFromPage(page: currentPage + 1)
    }
}
