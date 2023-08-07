//
//  DetailViewController.swift
//  MovieArchive
//
//  Created by Emre Çakır on 1.08.2023.
//

import UIKit
import Kingfisher

final class DetailViewController: UIViewController {
    
    private let viewModel = DetailViewModel()
    
    var movieID: Int = 0 {
        didSet {
            viewModel.fetchMovieDetail(movieID: movieID)
        }
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isDirectionalLockEnabled = true
        scrollView.contentInsetAdjustmentBehavior = .scrollableAxes
        return scrollView
    }()
    
    private let scrollContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let topContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "popcorn")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        return imageView
    }()
    
    private let infosStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private let voteStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    private let voteImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        return imageView
    }()
    
    private let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .systemYellow
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()
    
    private let voteReviewsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .label
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .label
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var genreCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.reusableIdentifier)
        return collectionView
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .tertiaryLabel
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        genreCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        genreCollectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = true
        super.viewWillDisappear(animated)
    }
    
    private func setupUI() {
        view.backgroundColor = .secondarySystemBackground
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = false
        viewModel.delegate = self
        
        scrollView.addSubview(scrollContentView)
        view.addSubview(scrollView)
        
        topContainerView.addSubview(movieImageView)
        scrollContentView.addSubview(topContainerView)
        
        voteStackView.addArrangedSubview(voteImage)
        voteStackView.addArrangedSubview(voteAverageLabel)
        voteStackView.addArrangedSubview(voteReviewsLabel)
        
        infosStackView.addArrangedSubview(voteStackView)
        infosStackView.addArrangedSubview(titleLabel)
        infosStackView.addArrangedSubview(genreCollectionView)
        infosStackView.addArrangedSubview(overviewLabel)
        scrollContentView.addSubview(infosStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollContentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            scrollContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            scrollContentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            topContainerView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            topContainerView.topAnchor.constraint(equalTo: scrollContentView.topAnchor),
            topContainerView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
            topContainerView.heightAnchor.constraint(equalTo: scrollContentView.heightAnchor, multiplier: 0.5),
            topContainerView.bottomAnchor.constraint(equalTo: infosStackView.topAnchor, constant: -20),
            
            movieImageView.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor),
            movieImageView.topAnchor.constraint(equalTo: topContainerView.topAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor),
            
            infosStackView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            infosStackView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
            infosStackView.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor),
            
            genreCollectionView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func movieDetailFetched() {
        if let movieDetail = viewModel.movieDetail {
            movieImageView.setImage(with: movieDetail.backdropPath, placeholder: "popcorn")
            voteAverageLabel.text = "\(String(format: "%.2f", movieDetail.voteAverage))"
            if movieDetail.voteCount >= 1000 {
                voteReviewsLabel.text = "(\((movieDetail.voteCount / 1000))k reviews)"
            } else {
                voteReviewsLabel.text = "(\(movieDetail.voteCount) reviews)"
            }
            
            titleLabel.text = movieDetail.title
            overviewLabel.text = movieDetail.overview
            
            DispatchQueue.main.async { [weak self] in
                self?.genreCollectionView.reloadData()
            }
            
        } else {
            print(movieID)
            navigationController?.popViewController(animated: true)
        }
    }
    
    func isLoading(_ state: Bool) {
        //        print(state)
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movieDetail?.genres.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.reusableIdentifier, for: indexPath) as? GenreCollectionViewCell {
            cell.configureCell(genreName: viewModel.movieDetail?.genres[indexPath.row].name ?? "")
            return cell
        }
        
        return GenreCollectionViewCell()
    }
}
