//
//  HomeVC.swift
//  Netflix Clone
//
//  Created by diayan siat on 25/02/2022.
//

import UIKit

class HomeVC: UIViewController {

    private lazy var homeFeedTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        layoutViews()
    }
    
    func layoutViews() {
        view.addSubview(homeFeedTableView)
        
        NSLayoutConstraint.activate([
            homeFeedTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeFeedTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeFeedTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeFeedTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as! CollectionViewTableViewCell
        cell.textLabel?.text = "Hello world"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
