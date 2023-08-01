//
//  BookmarksViewModel.swift
//  MovieArchive
//
//  Created by Emre Çakır on 23.07.2023.
//

import Foundation

protocol BookmarksViewModelDelegate: AnyObject {}

final class BookmarksViewModel{
    weak var delegate: BookmarksViewModelDelegate?
}
