//
//  MyMovieView.swift
//  Instabug-iOS-Assessment
//
//  Created by ahmed mahdy on 12/22/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import UIKit

class MyMovieViewController : UIViewController {
    private let presenter = MyMoviePresenter()
    
    @IBAction func doneButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancellButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var movieTitle: UITextField!
    @IBOutlet weak var movieDate: UITextField!
    @IBOutlet weak var movieOverview: UITextView!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func viewDidLoad() {
        self.presenter.setView(view: self)
        self.hideKeyboardWhenTappedAround()
    }
    
}
