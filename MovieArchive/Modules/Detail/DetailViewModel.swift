//
//  DetailViewModel.swift
//  MovieArchive
//
//  Created by Emre Çakır on 1.08.2023.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func movieDetailFetched()
}

final class DetailViewModel {
    weak var delegate: DetailViewModelDelegate?
    private let dataController: DetailDataControllerProtocol = DetailDataController()
    
    private var movieDetail: MovieDetailModel?
    
    func fetchMovieDetail(movieID: Int) {
        
    }
}
