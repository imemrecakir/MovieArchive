//
//  DiscoverViewModel.swift
//  MovieArchive
//
//  Created by Emre Çakır on 27.07.2023.
//

import Foundation

protocol DiscoverViewModelDelegate: AnyObject {
    func moviesSearched()
}

final class DiscoverViewModel {
    weak var delegate: DiscoverViewModelDelegate?
    private let dataController: DiscoverDataProtocol = DiscoverDataController()
    
    var movies: [MovieResultModel] = []
    var movie: MovieModel?
    var error: Error?
    
    func searchMovies(query: String) {
        dataController.searchMovies(query: query) { [weak self] result in
            switch result {
            case .success(let response):
                self?.movie = response
                self?.movies = response.results
                self?.delegate?.moviesSearched()
            case .failure(let failure):
                self?.error = failure
                self?.delegate?.moviesSearched()
            }
        }
    }
}
