//
//  SearchVC.swift
//  Netflix Clone
//
//  Created by diayan siat on 25/02/2022.
//

import UIKit

class SearchVC: UIViewController {
    
    private var movies = [Movies]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UpcomingTableViewCell.self, forCellReuseIdentifier: UpcomingTableViewCell.identifier)
        return tableView
    }()

    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultVC())
        controller.searchBar.placeholder = "Search for a Movie or Tv show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .white
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        fetchDiscoverMovies()
        searchController.searchResultsUpdater = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func fetchDiscoverMovies(){
        NetworkManager.shared.getDiscoverMovies { [weak self] results in
            switch results {
            case .success(let discover):
                self?.movies = discover
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifier, for: indexPath) as! UpcomingTableViewCell
        let titleName = movies[indexPath.row].originalName ?? movies[indexPath.row].originalTitle ?? "Unknown"
        cell.configure(with: PosterViewModel(titleName: titleName, posterUrl: movies[indexPath.row].posterPath ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let movie = movies[indexPath.row]
        guard let movieName = movie.originalTitle ?? movie.originalName else { return }
        
        NetworkManager.shared.getMovie(with: movieName + " trailer") { result in
            switch result {
            case .success(let video):
                DispatchQueue.main.async {
                    let vc = MovieTrailerPreviewVC()
                    vc.configure(with: MoviePreviewViewModel(title: movieName, youtubeView: video, titleOverview: movie.overview ?? ""))
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

extension SearchVC: UISearchResultsUpdating, SearchResultDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text,
        !query.trimmingCharacters(in: .whitespaces).isEmpty,
        query.trimmingCharacters(in: .whitespaces).count >= 3,
        let resultController = searchController.searchResultsController as? SearchResultVC  else {
            return
        }
        
        resultController.delegate = self
        
        NetworkManager.shared.searchMovie(query: query) { results in
            switch results {
            case .success(let searchResult):
                resultController.movies = searchResult
                DispatchQueue.main.async {
                    resultController.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func searchResultDidTapItem(_ viewModel: MoviePreviewViewModel) {
        DispatchQueue.main.async {
            let vc = MovieTrailerPreviewVC()
            vc.configure(with: viewModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
