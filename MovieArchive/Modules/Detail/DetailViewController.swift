//
//  DetailViewController.swift
//  MovieArchive
//
//  Created by Emre Çakır on 1.08.2023.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

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
    
    private let backdropImageView: UIImageView = {
      let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 24
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .redraw
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        imageView.image = UIImage(systemName: "popcorn")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        return imageView
    }()
    
    private let posterImageView: UIImageView = {
      let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .redraw
        imageView.image = UIImage(systemName: "popcorn")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        return imageView
    }()
    
    private let bookmarkImageView: UIImageView = {
      let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.secondaryLabel.cgColor
        imageView.layer.borderWidth = 0.75
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "bookmark")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    private let infosContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.isHidden = false
        viewModel.delegate = self
        viewModel.fetchMovieDetail(movieID: movieID)
        
        scrollView.addSubview(scrollContentView)
        view.addSubview(scrollView)
        
        topContainerView.addSubview(backdropImageView)
        topContainerView.addSubview(posterImageView)
        topContainerView.addSubview(bookmarkImageView)
        scrollContentView.addSubview(topContainerView)
        scrollContentView.addSubview(infosContainerView)
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
            topContainerView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.40),
            
            backdropImageView.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor),
            backdropImageView.topAnchor.constraint(equalTo: topContainerView.topAnchor),
            backdropImageView.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor),
            backdropImageView.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: -(view.frame.height * 0.4) * 0.15),
            
            posterImageView.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor, constant: 32),
//            posterImageView.topAnchor.constraint(equalTo: topContainerView.topAnchor, constant: view.frame.height * 0.4 * 0.25),
            posterImageView.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor),
            posterImageView.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: 0.4),
            posterImageView.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.6f),
            
            bookmarkImageView.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor, constant: -32),
            bookmarkImageView.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: -(view.frame.height * 0.4 * 0.05)),
            bookmarkImageView.heightAnchor.constraint(equalToConstant: 60),
            bookmarkImageView.widthAnchor.constraint(equalToConstant: 60),
            
            infosContainerView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            infosContainerView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor),
            infosContainerView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
            infosContainerView.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor)
        ])
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func movieDetailFetched() {
        if let movieDetail = viewModel.movieDetail {
            backdropImageView.setImage(with: movieDetail.backdropPath, placeholder: "popcorn")
            posterImageView.setImage(with: movieDetail.posterPath, placeholder: "popcorn")
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    func isLoading(_ state: Bool) {
//        print(state)
    }
}
