//
//  SearchResultVC.swift
//  Netflix Clone
//
//  Created by diayan siat on 28/02/2022.
//

import UIKit

protocol SearchResultDelegate: AnyObject {
    func searchResultDidTapItem(_ viewModel: MoviePreviewViewModel)
}

class SearchResultVC: UIViewController {
    var delegate: SearchResultDelegate?
    
    public var movies = [Movies]()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        return collectionView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
}

extension SearchResultVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as! PosterCollectionViewCell
        let posterPath = movies[indexPath.row].posterPath ?? "Unknown"
        cell.updatePoster(with: posterPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let movie = movies[indexPath.row]
        guard let movieName = movie.originalTitle ?? movie.originalName else { return }
        
        NetworkManager.shared.getMovie(with: movieName + " trailer") { result in
            switch result {
            case .success(let video):
                self.delegate?.searchResultDidTapItem(MoviePreviewViewModel(title: movieName, youtubeView: video, titleOverview: movie.overview ?? ""))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


