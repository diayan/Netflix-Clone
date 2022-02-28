//
//  PosterPreviewVC.swift
//  Netflix Clone
//
//  Created by diayan siat on 28/02/2022.
//

import UIKit
import WebKit

class MovieTrailerPreviewVC: UIViewController {

    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        return webView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Potter"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Best movie ever"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var downloadButton: UIButton = {
        let button  = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.backgroundColor = .systemRed
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        layoutViews()
    }
    
    
    private func layoutViews() {
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
}
