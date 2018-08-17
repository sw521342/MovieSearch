//
//  MovieDetailViewController.swift
//  MovieSearch
//
//  Created by S W on 8/14/18.
//  Copyright © 2018 S W. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var metascoreLabel: UILabel!
    @IBOutlet private weak var plotLabel: UILabel!
    
    var movie: Movie!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = movie.title
        titleLabel.text = movie.title
        
        movie.loadPosterImage() { [weak self] image in
            guard let strongSelf = self else {
                return
            }
            
            DispatchQueue.main.async {
                strongSelf.imageView.image = image
            }
        }
        
        movie.loadDetail() { [weak self] movieDetail in
            guard let strongSelf = self, let movieDetail = movieDetail else {
                return
            }
            
            DispatchQueue.main.async {
                strongSelf.metascoreLabel.text = "Metacritic Score: \(movieDetail.metascore)"
                strongSelf.plotLabel.text = movieDetail.plot
            }
        }
    }
}
