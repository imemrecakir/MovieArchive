//
//  DetailViewController.swift
//  MovieArchive
//
//  Created by Emre Çakır on 1.08.2023.
//

import UIKit

class DetailViewController: UIViewController {

    private let viewModel = DetailViewModel()
    var movieID: Int = 0 {
        didSet {
            viewModel.fetchMovieDetail(movieID: movieID)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        viewModel.delegate = self
        viewModel.fetchMovieDetail(movieID: movieID)
        print(movieID)
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = false
        navigationItem.backButtonTitle = "Back"
    }
    
    private func setupConstraints() {
        
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func movieDetailFetched() {
    }
    
    func isLoading(_ state: Bool) {
        print(state)
    }
}
