//
//  DetailDataController.swift
//  MovieArchive
//
//  Created by Emre Çakır on 1.08.2023.
//

import Foundation

protocol DetailDataControllerProtocol {
    func fetchMovieDetail(movieID: Int, completion: @escaping (Result<MovieDetailModel, Error>) -> Void)
    func bookmarkMovie(movie: MovieDetailModel, completion: @escaping (Bool) -> Void)
    
    func unBookmarkMovie(movie: MovieDetailModel, completion: @escaping (Bool) -> Void)
    
    func checkBookmarkMovie(movie: MovieDetailModel, completion: @escaping (Bool) -> Void)
}

final class DetailDataController: DetailDataControllerProtocol {
    
    func fetchMovieDetail(movieID: Int, completion: @escaping (Result<MovieDetailModel, Error>) -> Void) {
        let endpoint = Endpoint.getMovieDetail
        NetworkManager.shared.request(endpoint.request(with: movieID), completion: completion)
    }
    
    func bookmarkMovie(movie: MovieDetailModel, completion: @escaping (Bool) -> Void) {
        var mutableMovie = movie
        mutableMovie.timeStamp = Date().timeIntervalSince1970
        DatabaseManager.shared.save(mutableMovie, forKey: .savedMovies, completion: completion)
    }
    
    func unBookmarkMovie(movie: MovieDetailModel, completion: @escaping (Bool) -> Void) {
        DatabaseManager.shared.delete(movie, forKey: .savedMovies, completion: completion)
    }
    
    func checkBookmarkMovie(movie: MovieDetailModel, completion: @escaping (Bool) -> Void) {
        DatabaseManager.shared.check(movie, forKey: .savedMovies, completion: completion)
    }
}
