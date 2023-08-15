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
    case getNowPlayingMovies
    case getPopularMovies
    case getTopRatedMovies
    case getUpcomingMovies
    case getMovieDetail
    case getSearchMovie
}

extension Endpoint: EndpointProtocol {
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var path: String {
        switch self {
        case .getNowPlayingMovies:
            return "movie/now_playing"
        case .getPopularMovies:
            return "movie/popular"
        case .getTopRatedMovies:
            return "movie/top_rated"
        case .getUpcomingMovies:
            return "movie/upcoming"
        case .getMovieDetail:
            return "movie/"
        case .getSearchMovie:
            return "search/movie"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getNowPlayingMovies, .getPopularMovies, .getTopRatedMovies, .getUpcomingMovies, .getMovieDetail, .getSearchMovie:
            return .get
        }
    }
    
    var headers: HTTPHeaders {
        let token = EnvironmentManager.shared.getAccessToken()
        return [
            "accept": "application/json",
            "Authorization": "Bearer \(token)"
        ]
    }
    
    func request(parameters: [String: Any]? = nil) -> DataRequest {
        return AF.request("\(baseURL)\(path)", method: method, parameters: parameters, encoding: URLEncoding.init(destination: .queryString, arrayEncoding: .brackets, boolEncoding: .literal), headers: headers)
    }
    
    func request(with pathParameter: Any) -> DataRequest {
        return AF.request("\(baseURL)\(path)\(pathParameter)", method: method, headers: headers)
    }
}

