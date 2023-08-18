//
//  DetailViewModel.swift
//  MovieArchive
//
//  Created by Emre Çakır on 1.08.2023.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func movieDetailFetched()
    func movieBookmarked(_ result: Bool)
    func movieUnBookmarked(_ result: Bool)
    func movieBookmarkChecked(_ result: Bool)
    func isLoading(_ state: Bool)
}

final class DetailViewModel {
    weak var delegate: DetailViewModelDelegate?
    private let dataController: DetailDataControllerProtocol = DetailDataController()
    
    var movieDetail: MovieDetailModel?
    var isBookmarked = false
    var error: Error?
    
    func fetchMovieDetail(movieID: Int) {
        delegate?.isLoading(true)
        dataController.fetchMovieDetail(movieID: movieID) { [weak self] result in
            switch result {
            case .success(let response):
                self?.movieDetail = response
                self?.delegate?.movieDetailFetched()
                self?.checkBookmarkMovie()
                self?.delegate?.isLoading(false)
            case .failure(let error):
                self?.error = error
                self?.delegate?.movieDetailFetched()
                self?.delegate?.isLoading(false)
            }
        }
    }
    
    func bookmarkMovie() {
        delegate?.isLoading(true)
        if let movieDetail {
            dataController.bookmarkMovie(movie: movieDetail) { [weak self] result in
                self?.delegate?.movieBookmarked(result)
                self?.delegate?.isLoading(false)
            }
        } else {
            error = NSError(domain: "Movie does not exists", code: 0)
            delegate?.movieBookmarked(false)
            delegate?.isLoading(false)
        }
    }
    
    func unBookmarkMovie() {
        delegate?.isLoading(true)
        if let movieDetail {
            dataController.unBookmarkMovie(movie: movieDetail) { [weak self] result in
                self?.delegate?.movieUnBookmarked(result)
                self?.delegate?.isLoading(false)
            }
        } else {
            error = NSError(domain: "Movie does not exists", code: 0)
            delegate?.movieUnBookmarked(false)
            delegate?.isLoading(false)
        }
    }
    
    func checkBookmarkMovie() {
        delegate?.isLoading(true)
        if let movieDetail {
            dataController.checkBookmarkMovie(movie: movieDetail) { [weak self] result in
                self?.isBookmarked = result
                self?.delegate?.movieBookmarkChecked(result)
                self?.delegate?.isLoading(false)
            }
        } else {
            error = NSError(domain: "Movie does not exists", code: 0)
            delegate?.movieBookmarkChecked(false)
            delegate?.isLoading(false)
        }
    }
}
