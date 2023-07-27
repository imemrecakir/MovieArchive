//
//  ListViewController.swift
//  MovieArchive
//
//  Created by Emre Çakır on 23.07.2023.
//

import UIKit

final class ListViewController: UIViewController {

    private let viewModel = ListViewModel()
    
    private let categoryList = [GenreModel(id: 1, name: "Now Playing"),
                                GenreModel(id: 1, name: "Popular"),
                                GenreModel(id: 1, name: "Top Rated"),
                                GenreModel(id: 1, name: "Upcoming")]
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .default
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.width / 4) - 5, height: 50)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.reusableIdentifier)
        return collectionView
    }()
    
    private lazy var listCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.width / 2) - 5, height: view.frame.height / 3)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.reusableIdentifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        viewModel.fetchPopularMovies()
        viewModel.fetchTopRatedMovies()
//        viewModel.fetchMoviesByGenres(genre: GenreModel(id: 18, name: "Action"))
//        viewModel.fetchMoviesByGenres(genre: GenreModel(id: 12, name: "Adventure"))
        viewModel.fetchGenres()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Movie Archive"
        
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.addSubview(searchBar)
        view.addSubview(categoryCollectionView)
        view.addSubview(listCollectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryCollectionView.bottomAnchor.constraint(equalTo: listCollectionView.topAnchor, constant: -12),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 60),
            
            listCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 12),
            listCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func filterTapped() {
        print("Filter Tapped")
    }
}

extension ListViewController: ListViewModelDelegate {
    
    func popularMoviesFetched() {
        if viewModel.error != nil && viewModel.popularMovies.isEmpty {
            print("Error - \(String(describing: viewModel.error.debugDescription))")
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.listCollectionView.reloadData()
            }
        }
    }
    
    func topRatedMoviesFetched() {
        if viewModel.error != nil && viewModel.topRatedMovies.isEmpty {
            print("Error - \(String(describing: viewModel.error.debugDescription))")
        } else {
            // Update collectionView
        }
    }
    
    func moviesByGenreFetched(_ genre: GenreModel) {
        if viewModel.error != nil && viewModel.topRatedMovies.isEmpty {
            print("Error - \(String(describing: viewModel.error.debugDescription))")
        } else {
//            print(genre)
//            print(viewModel.moviesByGenre.count)
//            for movie in viewModel.moviesByGenre {
//                if movie.keys.contains(genre.name) {
//                    print(movie)
//                }
//            }
        }
    }
    
    func genresFetched() {
        if viewModel.error != nil && viewModel.genres.isEmpty {
            print("Error - \(String(describing: viewModel.error.debugDescription))")
        } else {
            categoryCollectionView.reloadData()
        }
    }
    
    func isLoading(_ state: Bool) {
        print("isLoading : \(state)")
    }
}

extension ListViewController: UISearchBarDelegate {
    
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == listCollectionView ? viewModel.popularMovies.count : categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == listCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.reusableIdentifier, for: indexPath) as? ListCollectionViewCell {
                cell.configureCell(movieModel: viewModel.popularMovies[indexPath.item])
                return cell
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reusableIdentifier, for: indexPath) as? CategoryCollectionViewCell {
                cell.configureCell(genreModel: categoryList[indexPath.item])
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
}
