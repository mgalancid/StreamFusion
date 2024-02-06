//
//  HomePageViewController.swift
//  StreamFusion
//
//  Created by Lautaro Galan on 04/02/2024.
//

import UIKit

class HomePageViewController: UIViewController {
    private let viewModel = HomePageViewModel(service: APIService())
    var moviesAndShows: [APIResponse.Data.MovieAndShow] = []
    var filteredMovies: [APIResponse.Data.MovieAndShow] = []
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        setupUI()
        setupSearchBar()
        setupUpdateHandler()
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(SearchResultsTableViewCell.self, forCellReuseIdentifier: SearchResultsTableViewCell.identifier)
        return tableView
    }()
    
    private func setupUI() {
        self.view.backgroundColor = .systemBlue
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150), // TODO: Avoid hardcoding the values
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func setupSearchBar() {
        self.searchBar.searchBarStyle = .prominent
        self.searchBar.placeholder = "Search..."
        self.searchBar.sizeToFit()
        self.searchBar.isTranslucent = true
        self.searchBar.backgroundImage = UIImage()
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func setupUpdateHandler() {
        viewModel.updateHandler = { [weak self] fetchedResults in
            DispatchQueue.main.async {
                self?.filteredMovies = fetchedResults
                self?.tableView.reloadData()
            }
        }
    }
}

extension HomePageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredMovies = []
            tableView.reloadData()
        } else {
            viewModel.fetchResults(title: searchText)
        }
    }
}

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsTableViewCell.identifier, for: indexPath) as! SearchResultsTableViewCell
        cell.textLabel?.text = filteredMovies[indexPath.row].l
        return cell
    }
}
