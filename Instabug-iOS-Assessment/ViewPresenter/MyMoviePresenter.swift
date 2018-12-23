//
//  MyMoviePresenter.swift
//  Instabug-iOS-Assessment
//
//  Created by ahmed mahdy on 12/22/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import Foundation

class MyMoviePresenter {
    weak private var view: MyMovieViewController?
    private let dataSourceInstance = MovieDataSource.instance

    var newMovieImageURL: URL?
    var movieTitle: String?
    var movieDate: String?
    var movieOverview: String?
    var moviePoster: String?
    
    func setView(view: MyMovieViewController) {
        self.view = view
    }
    func getMovieDataEntered(){
        movieTitle = self.view?.movieTitle.text
        movieDate = self.view?.movieDate.text
        movieOverview = self.view?.movieOverview.text
        moviePoster = self.view?.posterURL?.absoluteString
    }
    
    func setNewMovie(type: SelectedSegment){
        getMovieDataEntered()
        let addedMovie = Movie.init(title: movieTitle, overview: movieOverview, release_date: movieDate, poster_path: moviePoster)
       let provider:MovieRepository = MovieProviderRepository.getProviderInstance(providerType: type)
        
        provider.addNewMovie(movie: addedMovie)
        self.view?.addingComplete()
    }
}
