//
//  UpcomingTableViewCell.swift
//  Netflix Clone
//
//  Created by diayan siat on 27/02/2022.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {
    static let identifier = "UpcomingTableViewCell"
    
    private lazy var button: UIButton = {
        let button  = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.tintColor = .label
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    private lazy var comingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: PosterViewModel)  {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterUrl)") else {return}
        comingImageView.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.titleName
    }
    
    func layoutViews() {
        contentView.addSubview(comingImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            comingImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            comingImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            comingImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            comingImageView.widthAnchor.constraint(equalToConstant: 100),
            
            titleLabel.leadingAnchor.constraint(equalTo: comingImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
}
