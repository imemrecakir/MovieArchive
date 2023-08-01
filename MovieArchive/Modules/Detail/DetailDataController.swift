//
//  DetailDataController.swift
//  MovieArchive
//
//  Created by Emre Çakır on 1.08.2023.
//

import Foundation

protocol DetailDataControllerProtocol {
    func fetchMovieDetail(movieID: Int, completion: @escaping (Result<MovieDetailModel, Error>) -> Void)
}

final class DetailDataController: DetailDataControllerProtocol {
    
    func fetchMovieDetail(movieID: Int, completion: @escaping (Result<MovieDetailModel, Error>) -> Void) {
        let endpoint = Endpoint.getMovieDetail
        NetworkManager.shared.request(endpoint.request(with: movieID), completion: completion)
    }
}
