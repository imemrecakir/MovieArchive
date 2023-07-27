//
//  ListViewModel.swift
//  MovieArchive
//
//  Created by Emre Çakır on 23.07.2023.
//

import Foundation

protocol ListViewModelDelegate: AnyObject {
    func popularMoviesFetched()
    func topRatedMoviesFetched()
    func moviesByGenreFetched(_ genre: GenreModel)
    func genresFetched()
    func isLoading(_ state: Bool)
}

final class ListViewModel {
    weak var delegate: ListViewModelDelegate?
    private let dataController: ListDataControllerProtocol = ListDataController()
    
    var popularMovies: [MovieResultModel] = []
    var topRatedMovies: [MovieResultModel] = []
    var moviesByGenre = Set<[String: [MovieResultModel]]>()
    var genres: [GenreModel] = []
    var error: Error? = nil
    
    func fetchPopularMovies() {
        delegate?.isLoading(true)
        dataController.fetchPopularMovies { [weak self] result in
            switch result {
            case .success(let response):
                self?.popularMovies = response.results
                self?.delegate?.popularMoviesFetched()
                self?.delegate?.isLoading(false)
            case .failure(let error):
                self?.error = error
                self?.delegate?.popularMoviesFetched()
                self?.delegate?.isLoading(false)
            }
            
        }
    }
    
    func fetchTopRatedMovies() {
        delegate?.isLoading(true)
        dataController.fetchTopRatedMovies { [weak self] result in
            switch result {
            case .success(let response):
                self?.topRatedMovies = response.results
                self?.delegate?.topRatedMoviesFetched()
                self?.delegate?.isLoading(false)
            case .failure(let error):
                self?.error = error
                self?.delegate?.topRatedMoviesFetched()
                self?.delegate?.isLoading(false)
            }
        }
    }
    
    func fetchMoviesByGenres(genre: GenreModel) {
        delegate?.isLoading(true)
        dataController.fetchMoviesByGenres(genres: "\(genre.id)") { [weak self] result in
            switch result {
            case .success(let response):
                self?.moviesByGenre.insert([genre.name: response.results])
                self?.delegate?.moviesByGenreFetched(genre)
                self?.delegate?.isLoading(false)
            case .failure(let error):
                self?.error = error
                self?.delegate?.moviesByGenreFetched(genre)
                self?.delegate?.isLoading(false)
            }
            
        }
    }
    
    func fetchGenres() {
        delegate?.isLoading(true)
        dataController.fetchGenres { [weak self] result in
            switch result {
            case .success(let response):
                self?.genres = response.genres
                self?.delegate?.genresFetched()
                self?.delegate?.isLoading(false)
            case .failure(let error):
                self?.error = error
                self?.delegate?.genresFetched()
                self?.delegate?.isLoading(false)
            }
        }
    }
}
