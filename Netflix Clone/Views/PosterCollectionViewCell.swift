//
//  TitleCollectionViewCell.swift
//  Netflix Clone
//
//  Created by diayan siat on 26/02/2022.
//

import UIKit
import SDWebImage

class PosterCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PosterCollectionViewCell"
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    //updates poster for each cell. model holds the url string
    public func updatePoster(with model: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model)") else {return}
        posterImageView.sd_setImage(with: url, completed: nil)
    }
}
