//
//  DownloadsVC.swift
//  Netflix Clone
//
//  Created by diayan siat on 25/02/2022.
//

import UIKit

class DownloadsVC: UIViewController {
    private var movies = [MovieItem]()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UpcomingTableViewCell.self, forCellReuseIdentifier: UpcomingTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        title = "Downloads"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDownloadedMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func fetchDownloadedMovies() {
        DataPersistenceManager.shared.fetchFromCoreData { result in
            switch result {
            case .success(let movies):
                self.movies = movies
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension DownloadsVC: UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            DataPersistenceManager.shared.deleteCoreDataItem(model: movies[indexPath.row]) { result in
                switch result {
                case .success(()):
                    print("deleted from db")
                case .failure(let error):
                    print(error)
                }
                self.movies.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            print("some shit")
        }
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
