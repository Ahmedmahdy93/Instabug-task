//
//  MovieClient.swift
//  Instabug-iOS-Assessment
//
//  Created by ahmed mahdy on 12/21/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import Foundation
class MovieClient: APIClient {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func discover(page : Int , completion: @escaping (Result<MovieResult?, APIError>) -> Void){
        fetch(with: MovieCategory.discover(page).request , decode: { json -> MovieResult? in
            guard let movieCategoryResult = json as? MovieResult else { return  nil }
            return movieCategoryResult
        }, completion: completion)
    }
    func smallCoverUrl(movie: Movie) -> URL? {
        guard let path = movie.poster_path else{ return nil }
        if let url = URL(string: MovieCategory.posterPath + path) {
            return url
        }
        return nil
    }
}
