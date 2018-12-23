//
//  URLConversion.swift
//  Instabug-iOS-Assessment
//
//  Created by ahmed mahdy on 12/22/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import Foundation

func posterUrl(movie: Movie,localImage: Bool) -> URL {
    if localImage {
        guard let path = movie.poster_path else{ return URL(string: "nil")! }
        if let url = URL(string: path) {
            return url
        }
    }
    guard let path = movie.poster_path else{ return URL(string: "nil")! }
    if let url = URL(string: MovieCategory.posterPath + path) {
        return url
    }
    return URL(string: "nil")!
}
