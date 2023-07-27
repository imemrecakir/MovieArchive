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
    func request(parameters: [String: Any]?) -> DataRequest
}

enum Endpoint {
    case getPopularMovies
    case getTopRatedMovies
    case getGenres
    case getMoviesByGenres
}

extension Endpoint: EndpointProtocol {
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var path: String {
        switch self {
        case .getPopularMovies:
            return "movie/popular"
        case .getTopRatedMovies:
            return "movie/top_rated"
        case .getGenres:
            return "genre/movie/list"
        case .getMoviesByGenres:
            return "discover/movie"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getPopularMovies, .getTopRatedMovies, .getGenres, .getMoviesByGenres:
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
    
    func request(parameters: [String: Any]? = nil) -> DataRequest {
        return AF.request("\(baseURL)\(path)", method: method, parameters: parameters, headers: headers)
    }
}
