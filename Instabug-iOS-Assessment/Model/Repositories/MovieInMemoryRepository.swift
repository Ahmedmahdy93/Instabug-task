//
//  MovieInMemoryProvider.swift
//  Instabug-iOS-Assessment
//
//  Created by ahmed mahdy on 12/23/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import Foundation
class MovieInMemoryRepository: MovieRepository {
    
    var delegat: MovieRepositoryListener?
    var isLoading = false
    var currentPage = 0
    var lastMovieResult: MovieResult?
    var movies: [Movie]?
    
    func setDelegat(view: MovieRepositoryListener) {
        self.delegat = view
    }
    
    func loadMovies(){
        if self.lastMovieResult == nil {
            self.loadDataFromPage(page: 1)
        }
    }
    func loadNextPage(){
        loadDataFromPage(page: currentPage + 1)
    }
    func loadDataFromPage(page: Int) {
        MovieDataSource.instance.loadDataFromPage(page: page) { (movieResult) in
                self.setMovieResult(newList: movieResult)
                self.currentPage = page
            
        }
    }
    func addNewMovie( movie: Movie){
        MovieDataSource.instance.addNewMovie(movie: movie)
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
        self.delegat?.onFinishLoadingMovies(movies: self.movies)
    }
    func canLoadMore(indexPath: IndexPath) -> Bool{
        if let movies = self.movies {
            let lastRow = movies.count - 1
            if let page = self.lastMovieResult?.page {
                if indexPath.row == lastRow && page < self.lastMovieResult!.total_pages {
                    return true
                }
            }
        }
        return false
    }
}
