//
//  DiscoverViewController.swift
//  MovieArchive
//
//  Created by Emre Çakır on 27.07.2023.
//

import UIKit

final class DiscoverViewController: UIViewController {

    private let viewModel: DiscoverViewModel
    
    init(viewModel: DiscoverViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DiscoverViewController: DiscoverViewModelDelegate {}
