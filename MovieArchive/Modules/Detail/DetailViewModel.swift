//
//  DetailViewModel.swift
//  MovieArchive
//
//  Created by Emre Çakır on 1.08.2023.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func movieDetailFetched()
    func movieSaved()
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
    
    func saveMovie() {
        delegate?.isLoading(true)
        if let movieDetail {
            dataController.saveMovies(movie: movieDetail) { [weak self] result in
                self?.delegate?.movieSaved()
                self?.delegate?.isLoading(false)
            }
        } else {
            error = NSError(domain: "Movie can not saved", code: 0)
            delegate?.movieSaved()
            delegate?.isLoading(false)
        }
    }
}
