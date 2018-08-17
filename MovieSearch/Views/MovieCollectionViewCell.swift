//
//  MovieCollectionViewCell.swift
//  MovieSearch
//
//  Created by S W on 8/14/18.
//  Copyright © 2018 S W. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    func update(for movie: Movie) {
        titleLabel.text = movie.title
        
        movie.loadPosterImage()  { [weak self] image in
            guard let strongSelf = self else {
                return
            }
            
            DispatchQueue.main.async {
                strongSelf.imageView.image = image
            }
        }
    }
}
