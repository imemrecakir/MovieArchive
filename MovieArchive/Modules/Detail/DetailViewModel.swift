//
//  DetailViewModel.swift
//  MovieArchive
//
//  Created by Emre Çakır on 1.08.2023.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func movieDetailFetched()
    func isLoading(_ state: Bool)
}

final class DetailViewModel {
    weak var delegate: DetailViewModelDelegate?
    private let dataController: DetailDataControllerProtocol = DetailDataController()
    
    var movieDetail: MovieDetailModel?
    var error: Error? = nil
    
    func fetchMovieDetail(movieID: Int) {
        delegate?.isLoading(true)
        dataController.fetchMovieDetail(movieID: movieID) { [weak self] result in
            switch result {
            case .success(let response):
                self?.movieDetail = response
                self?.delegate?.movieDetailFetched()
                self?.delegate?.isLoading(false)
            case .failure(let error):
                self?.error = error
                self?.delegate?.movieDetailFetched()
                self?.delegate?.isLoading(false)
            }
        }
    }
}
