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
    
    @IBOutlet weak var moviesSegmentControl: UISegmentedControl!
    @IBOutlet weak var moviesTable: UITableView!
    
    private let presenter = MovieListPresenter()
    var dataSource : [Movie]?
    
    @IBAction func moviesSegmentSelected(_ sender: UISegmentedControl) {
        switch moviesSegmentControl.selectedSegmentIndex {
        case 1:
            self.presenter.loadMyMovies()
        case 0:
            self.presenter.loadMovies()
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.setView(view: self)
        
        moviesTable.delegate = self
        moviesTable.dataSource = self
        moviesTable.rowHeight = UITableView.automaticDimension
        moviesTable.estimatedRowHeight = 600
        
        
        moviesTable.register(UINib(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: "MovieListCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        switch moviesSegmentControl.selectedSegmentIndex {
        case 1:
            self.presenter.loadMyMovies()
        case 0:
            self.presenter.loadMovies()
        default:
            break
        }
        
    }

}
extension MovieListViewController: UITableViewDelegate,UITableViewDataSource{
    
    // MARK: - UITableViewDelegate Method
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if moviesSegmentControl.selectedSegmentIndex == 1 {
            return 50
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame: CGRect = tableView.frame
        let DoneBut: UIButton = UIButton(frame: CGRect(x: frame.size.width - 50, y: 0, width: 50, height: 50))
        DoneBut.setTitle("+", for: .normal)
        DoneBut.backgroundColor = UIColor.blue
        DoneBut.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.height, height: frame.size.width))
        headerView.addSubview(DoneBut)
        return headerView
    }
    
    
    @objc func pressed(sender: UIButton!) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Movies", bundle:nil)
        let addMovieViewController = storyBoard.instantiateViewController(withIdentifier: "MyMovieViewController") as! MyMovieViewController
        self.present(addMovieViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if moviesSegmentControl.selectedSegmentIndex == 0 {
            if self.presenter.canLoadMore(indexPath: indexPath) {
                let lastSectionIndex = moviesTable.numberOfSections - 1
                let lastRowIndex = moviesTable.numberOfRows(inSection: lastSectionIndex) - 1
                if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
                    addLoadingIndicator()
                    self.presenter.loadNextPage()
                }
            }
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
            if moviesSegmentControl.selectedSegmentIndex == 1{
                 let imageURL = posterUrl(movie: movie,localImage: true)
                cell.posterImage.load(url: imageURL)
            }
            else {
                let imageURL = posterUrl(movie: movie,localImage: false)
                    cell.posterImage.load(url: imageURL)
            }
        }
        
        return cell
    }
    
    func addLoadingIndicator(){
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: moviesTable.bounds.width, height: CGFloat(44))
        self.moviesTable.tableFooterView = spinner
        self.moviesTable.tableFooterView?.isHidden = false
    }
}
extension MovieListViewController: MovieListView {
    
    func finishLoading(movies: [Movie]) {
        dataSource = movies
        moviesTable.reloadData()
    }
}
