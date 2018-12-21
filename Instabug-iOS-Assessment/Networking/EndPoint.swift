//
//  EndPoint.swift
//  Instabug-iOS-Assessment
//
//  Created by ahmed mahdy on 12/21/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import Foundation
protocol Endpoint {
    var base : String { get }
    var path : String { get }
    var page : Int { get }
}

extension Endpoint {
    var apiKey : String {
        return "34a92f7d77a168fdcd9a46ee1863edf1"
    }
    var urlComponents: URLComponents {
        let apikeyQuery = URLQueryItem(name: "api_key", value: apiKey)
        let pageQuery = URLQueryItem(name: "page", value: String(page))
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = [apikeyQuery,pageQuery]
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}

enum MovieCategory {
    case discover(_ Page : Int)
}
extension MovieCategory: Endpoint {
    var page: Int {
        switch self {
        case .discover(let page):
            return page
        }
    }
    
    static let posterPath = "https://image.tmdb.org/t/p/w185"
    var base: String {
        return "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .discover: return "/3/discover/movie"
        }
    }
}
