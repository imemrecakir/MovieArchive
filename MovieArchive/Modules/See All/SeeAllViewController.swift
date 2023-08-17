//
//  SeeAllViewController.swift
//  MovieArchive
//
//  Created by Emre Çakır on 17.08.2023.
//

import UIKit

final class SeeAllViewController: UIViewController {

    private let viewModel = SeeAllViewModel()
    
    private lazy var seeAllCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.frame.width / 2) - 24, height: (view.frame.height / 3))
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16)
        collectionView.register(SeeAllCollectionViewCell.self, forCellWithReuseIdentifier: SeeAllCollectionViewCell.reusableIdentifier)
        return collectionView
    }()
    
    init(title: String, movies: [MovieResultModel], endpoint: Endpoint) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
        viewModel.movies = movies
        viewModel.endpoint = endpoint
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = true
        super.viewWillDisappear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        viewModel.delegate = self
        view.addSubview(seeAllCollectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            seeAllCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            seeAllCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            seeAllCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            seeAllCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension SeeAllViewController: SeeAllViewModelDelegate {
    
}

extension SeeAllViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeeAllCollectionViewCell.reusableIdentifier, for: indexPath) as? SeeAllCollectionViewCell {
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
