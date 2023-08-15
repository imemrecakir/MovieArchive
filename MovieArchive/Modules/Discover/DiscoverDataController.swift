//
//  DiscoverDataController.swift
//  MovieArchive
//
//  Created by Emre Çakır on 27.07.2023.
//

import Foundation
import Alamofire

protocol DiscoverDataProtocol {
    func searchMovies(query: String, completion: @escaping (Result<MovieModel, Error>) -> Void)
}

final class DiscoverDataController: DiscoverDataProtocol {
    
    func searchMovies(query: String, completion: @escaping (Result<MovieModel, Error>) -> Void) {
        let parameters: [String: Any] = [
            "query": query
        ]
        let endpoint = Endpoint.getSearchMovie
        let request = endpoint.request(parameters: parameters)
        NetworkManager.shared.request(request, completion: completion)
    }
}
