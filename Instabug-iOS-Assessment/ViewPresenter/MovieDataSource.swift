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
    
}
