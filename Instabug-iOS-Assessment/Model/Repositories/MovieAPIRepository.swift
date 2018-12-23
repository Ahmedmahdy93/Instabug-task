//
//  MovieAPIProvider.swift
//  Instabug-iOS-Assessment
//
//  Created by ahmed mahdy on 12/23/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import Foundation
class MovieAPIRepository: MovieRepository{
    func addNewMovie(movie: Movie)  {
        
    }
    
    var delegate: MovieRepositoryListener?
    
    var isLoading = false
    var currentPage = 0
    var lastMovieResult: MovieResult?
    var movies: [Movie]?
    
    private let client = MovieClient()
    
    func setDelegat(view: MovieRepositoryListener){
        self.delegate = view
    }
    
    func loadMovies(){
        if self.lastMovieResult == nil {
            self.loadDataFromPage(page: 1)
        }
    }
    func loadDataFromPage(page: Int) {
        if self.isLoading { return }
        self.isLoading = true
        
        print("loadDataFromPage ", page)
        client.discover(page: page) { [weak self] (result) in
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
    func loadNextPage() {
        loadDataFromPage(page: currentPage + 1)
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
}
