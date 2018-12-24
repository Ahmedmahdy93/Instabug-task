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
    
    weak private var view: MovieListViewDelegate?
    
    private let dataSourceInstance = MovieDataSource.instance
    var dataSource : [Movie]?
    
    var providerInstance: MovieRepository?
    
    func setProviderInstance(selectedSegment: SelectedSegment){
        providerInstance = MovieProviderRepository.getProviderInstance(providerType: selectedSegment)
        setDelegate(view: self)
        loadMoview()
    }
    func loadMoview(){
        providerInstance?.loadMovies()
    }
    func setDelegate(view: MovieRepositoryListener){
        providerInstance?.setDelegat(view: view)
    }
    func canLoadMore(indexPath: IndexPath) -> Bool {
        if let provider = providerInstance {
            return provider.canLoadMore(indexPath: indexPath)
        }
        return false
    }
    func setView(view: MovieListViewDelegate) {
        self.view = view
    }

    func loadNextPage() {
        providerInstance?.loadNextPage()
    }
    
}
extension MovieListPresenter: MovieRepositoryListener {
    func onFinishLoadingMovies(movies: [Movie]?) {
        self.dataSource = movies
        self.view?.finishLoading()
    }
}
