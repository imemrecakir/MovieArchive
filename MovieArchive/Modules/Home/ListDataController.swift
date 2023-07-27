//
//  ListDataController.swift
//  MovieArchive
//
//  Created by Emre Çakır on 23.07.2023.
//

import Foundation

protocol ListDataControllerProtocol {
    func fetchPopularMovies(completion: @escaping (Result<MovieModel, Error>) -> Void)
    func fetchTopRatedMovies(completion: @escaping (Result<MovieModel, Error>) -> Void)
    func fetchMoviesByGenres(genres: String, completion: @escaping (Result<MovieModel, Error>) -> Void)
    func fetchGenres(completion: @escaping (Result<GenreListModel, Error>) -> Void)
}

final class ListDataController: ListDataControllerProtocol {
  
    func fetchPopularMovies(completion: @escaping (Result<MovieModel, Error>) -> Void) {
        let endpoint = Endpoint.getPopularMovies
        NetworkManager.shared.request(endpoint.request(), completion: completion)
    }
    
    func fetchTopRatedMovies(completion: @escaping (Result<MovieModel, Error>) -> Void) {
        let endpoint = Endpoint.getTopRatedMovies
        NetworkManager.shared.request(endpoint.request(), completion: completion)
    }
    
    func fetchMoviesByGenres(genres: String, completion: @escaping (Result<MovieModel, Error>) -> Void) {
        let endpoint = Endpoint.getMoviesByGenres
        let parameters: [String: Any] = [
            "with_genres": genres
        ]
        NetworkManager.shared.request(endpoint.request(parameters: parameters), completion: completion)
    }
    
    func fetchGenres(completion: @escaping (Result<GenreListModel, Error>) -> Void) {
        let endpoint = Endpoint.getGenres
        NetworkManager.shared.request(endpoint.request(), completion: completion)
    }
}
