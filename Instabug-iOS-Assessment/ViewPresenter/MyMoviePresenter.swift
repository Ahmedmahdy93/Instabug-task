//
//  MyMoviePresenter.swift
//  Instabug-iOS-Assessment
//
//  Created by ahmed mahdy on 12/22/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import Foundation
class MyMoviePresenter {
    weak private var view: MyMovieViewController?
    
    
    func setView(view: MyMovieViewController) {
        self.view = view
    }
}
