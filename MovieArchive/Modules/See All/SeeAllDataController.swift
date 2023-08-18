//
//  SeeAllDataController.swift
//  MovieArchive
//
//  Created by Emre Çakır on 18.08.2023.
//

import Foundation

protocol SeeAllDataControllerProtocol {
    func fetchMovies(page: Int, endpoint: Endpoint, completion: @escaping (Result<MovieModel, Error>) -> Void)
}

final class SeeAllDataController: SeeAllDataControllerProtocol {
    func fetchMovies(page: Int, endpoint: Endpoint, completion: @escaping (Result<MovieModel, Error>) -> Void) {
        let parameters: [String: Any] = [
            "page": page
        ]
        let request = endpoint.request(parameters: parameters)
        NetworkManager.shared.request(request, completion: completion)
    }
}

