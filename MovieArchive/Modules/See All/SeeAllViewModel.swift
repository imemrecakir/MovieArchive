//
//  SeeAllViewModel.swift
//  MovieArchive
//
//  Created by Emre Çakır on 18.08.2023.
//

import Foundation

protocol SeeAllViewModelDelegate: AnyObject {
    func moviesFetched()
}

final class SeeAllViewModel {
    weak var delegate: SeeAllViewModelDelegate?
    private let dataController: SeeAllDataControllerProtocol = SeeAllDataController()
    
    var page = 2
    var movies: [MovieResultModel] = []
    var error: Error?
    var endpoint: Endpoint = .getNowPlayingMovies
    var totalPages: Int = 0
    
    func fetchMovies() {
        if totalPages != page {
            dataController.fetchMovies(page: page, endpoint: endpoint) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.page = response.page + 1
                    self?.totalPages = response.totalPages
                    self?.movies.append(contentsOf: response.results)
                    self?.delegate?.moviesFetched()
                case .failure(let error):
                    self?.error = error
                    self?.delegate?.moviesFetched()
                }
            }
        }
    }
}
