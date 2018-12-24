//
//  MyMoviePresenter.swift
//  Instabug-iOS-Assessment
//
//  Created by ahmed mahdy on 12/22/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import Foundation

class CreateMoviePresenter {
    weak private var view: CreateMovieViewController?
    
    func setView(view: CreateMovieViewController) {
        self.view = view
    }
    
    
    func setNewMovie(movie: Movie,type: SelectedSegment){
       let provider:MovieRepository = MovieProviderRepository.getProviderInstance(providerType: type)
        
        provider.addNewMovie(movie: movie)
        self.view?.addingComplete()
    }
}
