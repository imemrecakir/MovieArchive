//
//  DetailViewController.swift
//  MovieArchive
//
//  Created by Emre Çakır on 1.08.2023.
//

import UIKit

class DetailViewController: UIViewController {

    private let viewModel = DetailViewModel()
    private var movieID: Int = 0 {
        didSet {
            viewModel.fetchMovieDetail(movieID: movieID)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func movieDetailFetched() {
        
    }
}
