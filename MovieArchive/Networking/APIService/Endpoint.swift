//
//  Endpoint.swift
//  MovieArchive
//
//  Created by Emre Çakır on 26.07.2023.
//

import Alamofire
import Foundation

protocol EndpointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: Alamofire.HTTPMethod { get }
    var headers: HTTPHeaders { get }
    
    func request() -> DataRequest
}

enum Endpoint {
    case getPopularMovies
    case getTopRatedMovies
}

extension Endpoint: EndpointProtocol {
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/movie"
    }
    
    var path: String {
        switch self {
        case .getPopularMovies:
            return "/popular"
        case .getTopRatedMovies:
            return "/top_rated"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getPopularMovies, .getTopRatedMovies:
            return .get
        }
    }
    
    var headers: HTTPHeaders {
        let apiKey = EnvironmentManager.shared.getAccessToken()
        return [
          "accept": "application/json",
          "Authorization": "Bearer \(apiKey)"
        ]
    }
    
    func request() -> DataRequest {
        return AF.request("\(baseURL)\(path)", method: method, headers: headers)
    }
}
