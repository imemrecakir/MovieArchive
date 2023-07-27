//
//  GenreModel.swift
//  MovieArchive
//
//  Created by Emre Çakır on 27.07.2023.
//

import Foundation

struct GenreListModel: Codable {
    let genres: [GenreModel]
}

struct GenreModel: Codable {
    let id: Int
    let name: String
}

