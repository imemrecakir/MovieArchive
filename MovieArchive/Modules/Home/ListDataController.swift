//
//  ListDataController.swift
//  MovieArchive
//
//  Created by Emre Çakır on 23.07.2023.
//

import Foundation

protocol ListDataControllerProtocol {
    func fetchNowPlayingMovies(completion: @escaping (Result<MovieModel, Error>) -> Void)
    func fetchPopularMovies(completion: @escaping (Result<MovieModel, Error>) -> Void)
    func fetchTopRatedMovies(completion: @escaping (Result<MovieModel, Error>) -> Void)
    func fetchUpcomingMovies(completion: @escaping (Result<MovieModel, Error>) -> Void)
}

final class ListDataController: ListDataControllerProtocol {
  
    func fetchNowPlayingMovies(completion: @escaping (Result<MovieModel, Error>) -> Void) {
        let endpoint = Endpoint.getNowPlayingMovies
        NetworkManager.shared.request(endpoint.request(), completion: completion)
    }
    
    func fetchPopularMovies(completion: @escaping (Result<MovieModel, Error>) -> Void) {
        let endpoint = Endpoint.getPopularMovies
        NetworkManager.shared.request(endpoint.request(), completion: completion)
    }
    
    func fetchTopRatedMovies(completion: @escaping (Result<MovieModel, Error>) -> Void) {
        let endpoint = Endpoint.getTopRatedMovies
        NetworkManager.shared.request(endpoint.request(), completion: completion)
    }
    
    func fetchUpcomingMovies(completion: @escaping (Result<MovieModel, Error>) -> Void) {
        let endpoint = Endpoint.getUpcomingMovies
        NetworkManager.shared.request(endpoint.request(), completion: completion)
    }
}
