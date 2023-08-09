//
//  BookmarksDataController.swift
//  MovieArchive
//
//  Created by Emre Çakır on 23.07.2023.
//

import Foundation

protocol BookmarksDataControllerProtocol {
    func fetchMovies(completion: @escaping (Result<[MovieDetailModel], Error>) -> Void)
}

final class BookmarksDataController: BookmarksDataControllerProtocol {
        func fetchMovies(completion: @escaping (Result<[MovieDetailModel], Error>) -> Void) {
            DatabaseManager.shared.fetch(forKey: .savedMovies, completion: completion)
        }
}
