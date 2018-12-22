//
//  ViewController.swift
//  Instabug-iOS-Assessment
//
//  Created by ahmed mahdy on 12/21/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import UIKit

protocol MovieListView: NSObjectProtocol {
    func finishLoading(movies: [Movie])
}

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var moviesTable: UITableView!
    
    private let presenter = MovieListPresenter()
    
    var dataSource : [Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.setView(view: self)
        
        moviesTable.delegate = self
        moviesTable.dataSource = self
        moviesTable.register(UINib(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: "MovieListCell")
        moviesTable.register(UINib(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: "LoadingCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter.loadMovies()
    }

}
extension MovieListViewController: UITableViewDelegate,UITableViewDataSource{
    
    // MARK: - UITableViewDelegate Method
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.presenter.canLoadMore(indexPath: indexPath) {
            self.presenter.loadNextPage()
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieListCell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath) as! MovieListCell
        
        if let movie = dataSource?[indexPath.row] {
            cell.titleLabel.text = movie.title
            cell.dateLabel.text = movie.release_date
            cell.overviewLabel.text = movie.overview
            
            cell.posterImage.image = nil
            if let imageURL = presenter.posterUrl(movie: movie) {
                cell.posterImage.load(url: imageURL)
            }
        }
        
        return cell
    }
    
    
}
extension MovieListViewController: MovieListView {
    
    func finishLoading(movies: [Movie]) {
        dataSource = movies
        moviesTable.reloadData()
        // TODO: add callback for error!!!
    }
    
    
}
