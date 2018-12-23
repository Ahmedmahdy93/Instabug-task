//
//  MovieListPresenter.swift
//  Instabug-iOS-Assessment
//
//  Created by ahmed mahdy on 12/22/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import Foundation

protocol MovieRepositoryListener {
    func onFinishLoadingMovies(movies: [Movie]?)
}
class MovieListPresenter {
    
    weak private var view: MovieListView?
    
    private let dataSourceInstance = MovieDataSource.instance
    
    var providerInstance: MovieRepository?
    
    func presentMovies(selectedSegment: SelectedSegment){
        providerInstance = MovieProviderRepository.getProviderInstance(providerType: selectedSegment)
        providerInstance?.setDelegat(view: self)
        providerInstance?.loadMovies()
    }
    func canLoadMore(indexPath: IndexPath) -> Bool {
        return (providerInstance?.canLoadMore(indexPath: indexPath))!
    }
    func setView(view: MovieListView) {
        self.view = view
    }

    func loadNextPage() {
        providerInstance?.loadNextPage()
    }
    
}
extension MovieListPresenter: MovieRepositoryListener {
    func onFinishLoadingMovies(movies: [Movie]?) {
        self.view?.finishLoading(movies: movies)
    }
}
