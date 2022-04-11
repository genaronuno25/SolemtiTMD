//
//  MovieCollectionViewCell.swift
//  TheMovie
//
//  Created by gerardo.nuno on 08/04/22.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backGroundView: CustomView!
    @IBOutlet weak var ivCoverMovie: UIImageView!
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    @IBOutlet weak var lbNameMovie: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backGroundView.layer.masksToBounds = true
    }

    override func prepareForReuse() {
        ivCoverMovie.image = nil
        lbNameMovie.text = nil
        self.aiLoading.startAnimating()
    }
    
    func hideAnimetion() {
    }
    
    func setup(withMovie movie: Movie) {
        if let posterURL =  movie.posterPath {
            ivCoverMovie.setImageFromURL(toPath: posterURL, toType: .compressedImage, completion: { (complete) in
                DispatchQueue.main.async() {
                    if complete{
                        self.aiLoading.stopAnimating()
                        self.aiLoading.isHidden = true
                    }
                }
            })
        }else{
            self.aiLoading.stopAnimating()
            self.aiLoading.isHidden = true
            self.ivCoverMovie.isHidden = true
        }
        lbNameMovie.text = movie.originalTitle
    }
    
}
