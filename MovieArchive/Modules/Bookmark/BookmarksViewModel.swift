//
//  BookmarksViewModel.swift
//  MovieArchive
//
//  Created by Emre Çakır on 23.07.2023.
//

import Foundation

protocol BookmarksViewModelDelegate: AnyObject {
    func moviesFetched()
    func movieDeleted()
    func allMoviesDeleted()
}

final class BookmarksViewModel {
    weak var delegate: BookmarksViewModelDelegate?
    private let dataController: BookmarksDataControllerProtocol = BookmarksDataController()
    
    var movies: [MovieDetailModel] = [] {
        didSet {
            sortedByDateMovies = movies.reversed()
            sortedByNameMovies = movies.sorted { $0.title < $1.title }
        }
    }
    var sortedByDateMovies: [MovieDetailModel] = []
    var sortedByNameMovies: [MovieDetailModel] = []
    var error: Error?
    
    func fetchMovies() {
        dataController.fetchMovies { [weak self] result in
            switch result {
            case .success(let response):
                self?.movies = response
                self?.delegate?.moviesFetched()
            case .failure(let error):
                self?.error = error
                self?.delegate?.moviesFetched()
            }
        }
    }
    
    func deleteMovie(movie: MovieDetailModel) {
        
    }
    
    func deleteAllMovies() {
        
    }
}
