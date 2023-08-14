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
    
    private let dispatchGroup = DispatchGroup()
    
    func fetchNowPlayingMovies() {
        dispatchGroup.enter()
        delegate?.isLoading(true)
        dataController.fetchNowPlayingMovies { [weak self] result in
            switch result {
            case .success(let response):
                self?.nowPlayingMovies = response.results
                self?.delegate?.nowPlayingMoviesFetched()
            case .failure(let error):
                self?.error = error
                self?.delegate?.nowPlayingMoviesFetched()
            }
            self?.dispatchGroup.leave()
        }
    }
    
    func fetchPopularMovies() {
        dispatchGroup.enter()
        dataController.fetchPopularMovies { [weak self] result in
            switch result {
            case .success(let response):
                self?.popularMovies = response.results
                self?.delegate?.popularMoviesFetched()
            case .failure(let error):
                self?.error = error
                self?.delegate?.popularMoviesFetched()
            }
            self?.dispatchGroup.leave()
        }
    }
    
    func fetchTopRatedMovies() {
        dispatchGroup.enter()
        dataController.fetchTopRatedMovies { [weak self] result in
            switch result {
            case .success(let response):
                self?.topRatedMovies = response.results
                self?.delegate?.topRatedMoviesFetched()
            case .failure(let error):
                self?.error = error
                self?.delegate?.topRatedMoviesFetched()
            }
            self?.dispatchGroup.leave()
        }
    }
    
    func fetchUpcomingMovies() {
        dispatchGroup.enter()
        dataController.fetchUpcomingMovies { [weak self] result in
            switch result {
            case .success(let response):
                self?.upcomingMovies = response.results
                self?.delegate?.upcomingMoviesFetched()
            case .failure(let error):
                self?.error = error
                self?.delegate?.upcomingMoviesFetched()
            }
            self?.dispatchGroup.leave()
            self?.dispatchGroup.notify(queue: .main, execute: { [weak self] in
                self?.delegate?.isLoading(false)
            })
        }
    }
}
