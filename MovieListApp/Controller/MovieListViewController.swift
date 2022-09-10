//
//  MovieListViewController.swift
//  MovieListApp
//
//  Created by Mashqur Habib Himel on 9/9/22.
//

import UIKit

class MovieListViewController: UIViewController {
    
    private var movieFeed: [Movie] = []
    
     private let verticalStackView: UIStackView = {
        let vStack = UIStackView()
         vStack.translatesAutoresizingMaskIntoConstraints = false
         vStack.axis = .vertical
         vStack.distribution = .fill
         vStack.alignment = .fill
         vStack.isLayoutMarginsRelativeArrangement = true
         vStack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return vStack
    }()
    
    private let movieList: UITableView = {
        let movieList = UITableView()
        movieList.translatesAutoresizingMaskIntoConstraints = false
        movieList.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        return movieList
    }()
    
    private let movieListtableTitle: UILabel = {
        let movieListTableTitle = UILabel()
        movieListTableTitle.translatesAutoresizingMaskIntoConstraints = false
        movieListTableTitle.text = "Movie List"
        movieListTableTitle.font = .systemFont(ofSize: 25)
        movieListTableTitle.textColor = .black
        return movieListTableTitle
    }()
    
    private let searchBar: UISearchBar = {
        let searchbar = UISearchBar()
        searchbar.sizeToFit()
        return searchbar
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchBar
        setUpView()
        movieList.delegate = self
        movieList.dataSource = self
        setUpLayoutConstrains()
        updateView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movieList.estimatedRowHeight = 150
        movieList.rowHeight = UITableView.automaticDimension
    }
    
    
    func setUpView() {
        view.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(movieListtableTitle)
        verticalStackView.addArrangedSubview(movieList)
    }
    
    func setUpLayoutConstrains() {
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func updateView() {
        Task {
            do {
                let items = try await NetworkManager.shared.getMovieFeed()
                movieFeed = items
                movieList.reloadData()
            } catch let error {
                print("\(error.localizedDescription)")
            }
        }
    }

}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieFeed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        
        let movie = movieFeed[indexPath.row]
        cell.configure(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
