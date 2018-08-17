//
//  MovieSearchViewController.swift
//  MovieSearch
//
//  Created by S W on 8/14/18.
//  Copyright © 2018 S W. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MovieCell"

class MovieSearchViewController: UICollectionViewController {
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupSearchController()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? MovieDetailViewController, let cell = sender as? MovieCollectionViewCell, let indexPath = collectionView?.indexPath(for: cell) {
            let movie = movies[indexPath.row]
            destinationViewController.movie = movie
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        
        // Configure the cell
        let movie = movies[indexPath.row]
        cell.update(for: movie)
        
        return cell
    }
}

extension MovieSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        MovieSearch.forTitle(searchController.searchBar.text) { [weak self] movieSearch in
            guard let strongSelf = self, let movieSearch = movieSearch else {
                return
            }
            
            DispatchQueue.main.async {
                strongSelf.movies = movieSearch.movies
                strongSelf.collectionView?.reloadData()
            }
        }
    }
}

private extension MovieSearchViewController {
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.placeholder = "Search Movies"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}
