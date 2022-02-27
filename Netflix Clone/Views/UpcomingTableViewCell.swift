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
 //       button.setTitle("Play", for: .normal)
//        button.layer.borderColor = UIColor.label.cgColor
//        button.layer.borderWidth = 1
//        button.layer.cornerRadius = 5
 //       button.setTitleColor(.label, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    private lazy var comingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
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

    
    func layoutViews() {
        contentView.addSubview(comingImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            comingImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            comingImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            comingImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            comingImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
}
