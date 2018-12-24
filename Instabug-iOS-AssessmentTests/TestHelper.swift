//
//  TestHelper.swift
//  Instabug-iOS-AssessmentTests
//
//  Created by ahmed mahdy on 12/24/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import Foundation
@testable import Instabug_iOS_Assessment

struct TestHelper {
    static let movie1 = Movie(title: "Venom", overview: "Investigative journalist Eddie Brock attempts a comeback following a scandal, but accidentally becomes the host of an alien symbiote that gives him a violent super alter-ego: Venom. Soon, he must rely on his newfound powers to protect the world from a shadowy organization looking for a symbiote of their own.", release_date: "2018-10-03", poster_path: "/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg")
    static let movie2 = Movie(title: "Fantastic Beasts: The Crimes of Grindelwald", overview: "Gellert Grindelwald has escaped imprisonment and has begun gathering followers to his cause—elevating wizards above all non-magical beings. The only one capable of putting a stop to him is the wizard he once called his closest friend, Albus Dumbledore. However, Dumbledore will need to seek help from the wizard who had thwarted Grindelwald once before, his former student Newt Scamander, who agrees to help, unaware of the dangers that lie ahead. Lines are drawn as love and loyalty are tested, even among the truest friends and family, in an increasingly divided wizarding world.", release_date: "2018-11-14", poster_path: "/kQKcbJ9uYkTQql2R8L4jTUz7l90.jpg")
     static let movie3 = Movie(title: "Bumblebee", overview: "On the run in the year 1987, Bumblebee finds refuge in a junkyard in a small Californian beach town. Charlie, on the cusp of turning 18 and trying to find her place in the world, discovers Bumblebee, battle-scarred and broken.  When Charlie revives him, she quickly learns this is no ordinary yellow VW bug.", release_date: "2018-12-15", poster_path: "/sG6n4ei1F0kVQtTs3fAjDghngpa.jpg")
    static let movie4 = Movie(title: "Aquaman", overview: "Arthur Curry learns that he is the heir to the underwater kingdom of Atlantis, and must step forward to lead his people and be a hero to the world.", release_date: "2018-12-07", poster_path: "/i2dF9UxOeb77CAJrOflj0RpqJRF.jpg")
    static let movieInformation : MovieResult = MovieResult(page: 1, total_pages: 1, total_results: 10, results: [movie1,movie2,movie3,movie4])
    
//    static let movieInformation: MovieResult = [
//        "page":1,
//        "total_results":393934,
//        "total_pages":19697,
//        "results": [
//            [
//                "vote_count":734,
//                "id":297802,
//                "video":false,
//                "vote_average":7,
//                "title":"Aquaman",
//                "popularity":635.951,
//                "poster_path":"/i2dF9UxOeb77CAJrOflj0RpqJRF.jpg",
//                "original_language":"en",
//                "original_title":"Aquaman",
//                "genre_ids":[28,14,878,12],
//                "backdrop_path":"/5A2bMlLfJrAfX9bqAibOL2gCruF.jpg",
//                "adult":false,
//                "overview":"Arthur Curry learns that he is the heir to the underwater kingdom of Atlantis, and must step forward to lead his people and be a hero to the world.",
//                "release_date":"2018-12-07"
//            ],
//
//            [
//                "vote_count":151,
//                "id":424783,
//                "video":false,
//                "vote_average":6.6,
//                "title":"Bumblebee",
//                "popularity":358.381,"poster_path":"/sG6n4ei1F0kVQtTs3fAjDghngpa.jpg",
//                "original_language":"en",
//                "original_title":"Bumblebee",
//                "genre_ids":[28,12,878],
//                "backdrop_path":"/wtZj5nn6hVwgakPdg6y6gm3eFXU.jpg",
//                "adult":false,
//                "overview":"On the run in the year 1987, Bumblebee finds refuge in a junkyard in a small Californian beach town. Charlie, on the cusp of turning 18 and trying to find her place in the world, discovers Bumblebee, battle-scarred and broken.  When Charlie revives him, she quickly learns this is no ordinary yellow VW bug.",
//                "release_date":"2018-12-15"
//            ],
//            [
//
//                "vote_count":2354,
//                "id":338952,
//                "video":false,
//                "vote_average":7,
//                "title":"Fantastic Beasts: The Crimes of Grindelwald",
//                "popularity":252.146,
//                "poster_path":"/kQKcbJ9uYkTQql2R8L4jTUz7l90.jpg"
//                ,"original_language":"en",
//                 "original_title":"Fantastic Beasts: The Crimes of Grindelwald",
//                 "genre_ids":[10751,14,12],"backdrop_path":"/wDN3FIcQQ1HI7mz1OOKYHSQtaiE.jpg",
//                 "adult":false,
//                 "overview":"Gellert Grindelwald has escaped imprisonment and has begun gathering followers to his cause—elevating wizards above all non-magical beings. The only one capable of putting a stop to him is the wizard he once called his closest friend, Albus Dumbledore. However, Dumbledore will need to seek help from the wizard who had thwarted Grindelwald once before, his former student Newt Scamander, who agrees to help, unaware of the dangers that lie ahead. Lines are drawn as love and loyalty are tested, even among the truest friends and family, in an increasingly divided wizarding world.",
//                 "release_date":"2018-11-14"
//            ],
//            [
//                "vote_count":3443,
//                "id":335983,
//                "video":false,
//                "vote_average":6.5,
//                "title":"Venom",
//                "popularity":212.601,
//                "poster_path":"/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg",
//                "original_language":"en",
//                "original_title":"Venom",
//                "genre_ids":[878],"backdrop_path":"/VuukZLgaCrho2Ar8Scl9HtV3yD.jpg",
//                "adult":false,
//                "overview":"Investigative journalist Eddie Brock attempts a comeback following a scandal, but accidentally becomes the host of an alien symbiote that gives him a violent super alter-ego: Venom. Soon, he must rely on his newfound powers to protect the world from a shadowy organization looking for a symbiote of their own.",
//                "release_date":"2018-10-03"
//            ]
//        ]
//    ]
    
//    static let movie: Movie =
//        [
//        "vote_count":3443,
//        "id":335983,
//        "video":false,
//        "vote_average":6.5,
//        "title":"Venom",
//        "popularity":212.601,
//        "poster_path":"/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg",
//        "original_language":"en",
//        "original_title":"Venom",
//        "genre_ids":[878],"backdrop_path":"/VuukZLgaCrho2Ar8Scl9HtV3yD.jpg",
//        "adult":false,
//        "overview":"Investigative journalist Eddie Brock attempts a comeback following a scandal, but accidentally becomes the host of an alien symbiote that gives him a violent super alter-ego: Venom. Soon, he must rely on his newfound powers to protect the world from a shadowy organization looking for a symbiote of their own.",
//        "release_date":"2018-10-03"
//    ]
    
    
}
