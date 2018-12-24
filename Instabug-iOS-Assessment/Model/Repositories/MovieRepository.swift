//
//  MovieProovider.swift
//  Instabug-iOS-Assessment
//
//  Created by ahmed mahdy on 12/23/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import Foundation
protocol MovieRepository{
    func loadDataFromPage(page: Int)
    func addNewMovie( movie: Movie)
    func setDelegat(view: MovieRepositoryListener)
    func setMovieResult(newList: MovieResult?)
    func canLoadMore(indexPath: IndexPath) -> Bool
    func loadMovies()
    func loadNextPage()
    
}
