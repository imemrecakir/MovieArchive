//
//  DiscoverViewModel.swift
//  MovieArchive
//
//  Created by Emre Çakır on 27.07.2023.
//

import Foundation

protocol DiscoverViewModelDelegate: AnyObject {}

final class DiscoverViewModel {
    weak var delegate: DiscoverViewModelDelegate?
}
