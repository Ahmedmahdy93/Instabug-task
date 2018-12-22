//
//  MovieListPresenter.swift
//  Instabug-iOS-Assessment
//
//  Created by ahmed mahdy on 12/22/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import Foundation

protocol MoviePresenter {
    func setView(view: MovieListView)
    func loadMovies()
}
enum source {
    case networking(_ movie: [Movie])
    case myMovies(_ movies: [Movie])
    var movies: [Movie] {
        switch self {
        case .networking(let movies):
            return movies
        case .myMovies(let movies):
            return movies
        }
    }
}
class MovieListPresenter : MoviePresenter {
    
    weak private var view: MovieListView?
    private let client = MovieClient()
    
    var isLoading = false
    var currentPage = 0
    var movies: [Movie]?
    var lastMovieResult: MovieResult?
    
    func setView(view: MovieListView) {
        self.view = view
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
        self.loadDataFromPage(page: self.currentPage + 1)
    }
    
    func setMovieResult(newList: MovieResult) {
        self.lastMovieResult = newList
        if self.movies == nil {
            self.movies = newList.results
        }else{
            self.movies?.append(contentsOf: newList.results!)
        }
        self.view?.finishLoading(movies: self.movies!)
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
func posterUrl(movie: Movie) -> URL? {
    guard let path = movie.poster_path else{ return nil }
    if let url = URL(string: MovieCategory.posterPath + path) {
        return url
    }
    return nil
}
