//
//  MovieResult.swift
//  Instabug-iOS-Assessment
//
//  Created by ahmed mahdy on 12/21/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import Foundation
struct MovieResult: Decodable {
    var page: Int
    var total_pages: Int
    var total_results: Int
    let results: [Movie]?
}
