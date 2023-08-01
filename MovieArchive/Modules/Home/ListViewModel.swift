//
//  ListViewModel.swift
//  MovieArchive
//
//  Created by Emre Çakır on 23.07.2023.
//

import Foundation

protocol ListViewModelDelegate: AnyObject {
    func nowPlayingMoviesFetched()
    func popularMoviesFetched()
    func topRatedMoviesFetched()
    func upcomingMoviesFetched()
    func isLoading(_ state: Bool)
}

final class ListViewModel {
    weak var delegate: ListViewModelDelegate?
    private let dataController: ListDataControllerProtocol = ListDataController()
    
    let categoryList = ["Now Playing", "Popular", "Top Rated", "Upcoming"]
    var nowPlayingMovies: [MovieResultModel] = []
    var popularMovies: [MovieResultModel] = []
    var topRatedMovies: [MovieResultModel] = []
    var upcomingMovies: [MovieResultModel] = []
    var error: Error? = nil
    
    func fetchNowPlayingMovies() {
        delegate?.isLoading(true)
        dataController.fetchNowPlayingMovies { [weak self] result in
            switch result {
            case .success(let response):
                self?.nowPlayingMovies = response.results
                self?.delegate?.nowPlayingMoviesFetched()
                self?.delegate?.isLoading(false)
            case .failure(let error):
                self?.error = error
                self?.delegate?.nowPlayingMoviesFetched()
                self?.delegate?.isLoading(false)
            }
        }
    }
    
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
    
    func fetchUpcomingMovies() {
        delegate?.isLoading(true)
        dataController.fetchUpcomingMovies { [weak self] result in
            switch result {
            case .success(let response):
                self?.upcomingMovies = response.results
                self?.delegate?.upcomingMoviesFetched()
                self?.delegate?.isLoading(false)
            case .failure(let error):
                self?.error = error
                self?.delegate?.upcomingMoviesFetched()
                self?.delegate?.isLoading(false)
            }
        }
    }
}
