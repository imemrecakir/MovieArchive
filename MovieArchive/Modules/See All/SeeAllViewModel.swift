//
//  SeeAllViewModel.swift
//  MovieArchive
//
//  Created by Emre Çakır on 18.08.2023.
//

import Foundation

protocol SeeAllViewModelDelegate: AnyObject {
    
}

final class SeeAllViewModel {
    weak var delegate: SeeAllViewModelDelegate?
    private let dataController: DiscoverDataProtocol = DiscoverDataController()
    
    var page = 2
    var movies: [MovieResultModel] = []
    var error: Error? = nil
    var endpoint: Endpoint = .getNowPlayingMovies
    
    func fetchMovies() {
        
    }
}
