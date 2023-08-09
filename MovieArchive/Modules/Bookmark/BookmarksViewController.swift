//
//  BookmarksViewController.swift
//  MovieArchive
//
//  Created by Emre Çakır on 23.07.2023.
//

import UIKit
import Kingfisher

final class BookmarksViewController: UIViewController {
    
    private let viewModel = BookmarksViewModel()
    
    private lazy var bookmarksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.itemSize = CGSize(width: (view.frame.width / 2) - 24, height: (view.frame.height / 3))
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16)
        collectionView.register(BookmarksCollectionViewCell.self, forCellWithReuseIdentifier: BookmarksCollectionViewCell.reusableIdentifier)
        return collectionView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchMovies()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        viewModel.delegate = self
        view.addSubview(bookmarksCollectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bookmarksCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bookmarksCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bookmarksCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bookmarksCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension BookmarksViewController: BookmarksViewModelDelegate {
    func moviesFetched() {
        DispatchQueue.main.async { [weak self] in
            self?.bookmarksCollectionView.reloadData()
        }
    }
    
    func movieDeleted() {
        
    }
    
    func allMoviesDeleted() {
        
    }
}

extension BookmarksViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookmarksCollectionViewCell.reusableIdentifier, for: indexPath) as? BookmarksCollectionViewCell {
            cell.configureCell(movieModel: viewModel.movies[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.movieID = viewModel.movies[indexPath.row].id
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

