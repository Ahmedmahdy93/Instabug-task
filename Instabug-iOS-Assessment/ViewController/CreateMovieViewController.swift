//
//  MyMovieView.swift
//  Instabug-iOS-Assessment
//
//  Created by ahmed mahdy on 12/22/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import UIKit

protocol MyMovieData {
    func addingComplete()
}
class CreateMovieViewController : UIViewController,UITextViewDelegate {
    private let presenter = CreateMoviePresenter()
    
    @IBAction func doneButton(_ sender: Any) {
        
        self.presenter.setNewMovie(movie: createMovie(), type: .MyMovies)
    }

    @IBAction func cancellButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        movieOverview.text = ""
    }

    @IBOutlet weak var movieTitle: UITextField!
    @IBOutlet weak var movieDate: UITextField!
    @IBOutlet weak var movieOverview: UITextView!
    var posterURL : URL?
    @IBAction func chooseImage(_ sender: Any) {
        ImagePickerManager().pickImage(self){ [weak self] image in
            self?.posterURL = image
        }
    }
    
    override func viewDidLoad() {
        self.presenter.setView(view: self)
        self.hideKeyboardWhenTappedAround()
        movieOverview.delegate = self
    }
    func createMovie() -> Movie{
        let movie = Movie.init(title: self.movieTitle.text, overview: self.movieOverview.text, release_date: self.movieDate.text, poster_path: self.posterURL?.absoluteString)
        return movie
    }
}
extension CreateMovieViewController: MyMovieData{
    func addingComplete() {
        self.dismiss(animated: true, completion: nil)
    }
}
