//
//  MovieDataSource.swift
//  Instabug-iOS-Assessment
//
//  Created by ahmed mahdy on 12/22/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import Foundation
class MovieDataSource {
    
    static let instance = MovieDataSource()
     let pageSize = 6
    
    var myMovies: [Movie]?
    
    private init(){
    }
    
    func addNewMovie( movie: Movie){
        if myMovies == nil {
            myMovies = [movie]
        }
        else {
            myMovies?.append(movie)
        }
    }
    func loadDataFromPage(page: Int,onSuccess : @escaping (MovieResult?)->()){
        if myMovies == nil || (myMovies != nil && myMovies?.count == 0) {
            onSuccess(nil)
        }
        else {
        let startIndex = (page - 1) * pageSize
        var endIndex = (page * pageSize) - 1
            if endIndex >= (myMovies?.count)! {
                endIndex = (myMovies?.count)! - 1
            }
        let slice : ArraySlice<Movie>
        var totalPages = ((myMovies?.count)! / pageSize)
            if totalPages * pageSize < (myMovies?.count)!{
                totalPages += 1
            }
            slice = myMovies![startIndex...endIndex]
            let result: [Movie] = Array(slice)
            let movie = MovieResult.init(page: page, total_pages: totalPages, total_results: slice.count, results: result)
            onSuccess(movie)
    }
    }
}
