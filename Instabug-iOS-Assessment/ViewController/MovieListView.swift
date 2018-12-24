//
//  ViewController.swift
//  Instabug-iOS-Assessment
//
//  Created by ahmed mahdy on 12/21/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import UIKit

protocol MovieListView: NSObjectProtocol {
    func finishLoading()
}

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var moviesSegmentControl: UISegmentedControl!
    @IBOutlet weak var moviesTable: UITableView!
    
    private let presenter = MovieListPresenter()
    
    
    @IBAction func moviesSegmentSelected(_ sender: UISegmentedControl) {
        self.presenter.presentMovies( selectedSegment: SelectedSegment(rawValue: moviesSegmentControl!.selectedSegmentIndex)!)
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
        self.presenter.presentMovies( selectedSegment: SelectedSegment(rawValue: moviesSegmentControl!.selectedSegmentIndex)!)
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
        let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 50))
        headerView.addSubview(DoneBut)
        return headerView
    }
    
    
    @objc func pressed(sender: UIButton!) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Movies", bundle:nil)
        let addMovieViewController = storyBoard.instantiateViewController(withIdentifier: "MyMovieViewController") as! CreateMovieViewController
        self.present(addMovieViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        loadMore(indexPath: indexPath, type: SelectedSegment(rawValue: moviesSegmentControl!.selectedSegmentIndex)!)
        
    }
    
    func loadMore(indexPath: IndexPath,type:SelectedSegment){
        let lastSectionIndex = moviesTable.numberOfSections - 1
        let lastRowIndex = moviesTable.numberOfRows(inSection: lastSectionIndex) - 1
        if self.presenter.canLoadMore(indexPath: indexPath) {
            if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
                addLoadingIndicator()
                self.presenter.loadNextPage()
            }
        }
    }
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieListCell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath) as! MovieListCell
        
        if let movie = self.presenter.dataSource?[indexPath.row] {
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
    func removeLoadingIndicator(){
        self.moviesTable.tableFooterView?.isHidden = true
    }
}
extension MovieListViewController: MovieListView {
    
    func finishLoading() {
        removeLoadingIndicator()
        moviesTable.reloadData()
    }
}

enum SelectedSegment:Int{
    case AllMovies = 0
    case MyMovies = 1
}
