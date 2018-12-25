//
//  MovieProviderFactory.swift
//  Instabug-iOS-Assessment
//
//  Created by ahmed mahdy on 12/23/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import Foundation
class MovieProviderRepository {
    
    static func getProviderInstance(providerType: SelectedSegment) -> MovieRepository{
        switch providerType {
        case .AllMovies:
            return MovieAPIRepository()
        case .MyMovies:
            return MovieInMemoryRepository()
        }
    }
    
}
