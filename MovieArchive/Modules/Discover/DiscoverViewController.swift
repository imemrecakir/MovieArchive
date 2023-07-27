//
//  DiscoverViewController.swift
//  MovieArchive
//
//  Created by Emre Çakır on 27.07.2023.
//

import UIKit

final class DiscoverViewController: UIViewController {

    private let viewModel = DiscoverViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
}

extension DiscoverViewController: DiscoverViewModelDelegate {
    
}
