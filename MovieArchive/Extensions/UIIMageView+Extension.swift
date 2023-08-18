//
//  UIIMageView+Extension.swift
//  MovieArchive
//
//  Created by Emre Çakır on 27.07.2023.
//

import UIKit

extension UIImageView {
    private var baseImageURL: String {
       return "https://image.tmdb.org/t/p/original"
    }
    
    func setImage(with imageEndpoint: String?) {
        let url = URL(string: "\(baseImageURL)\(imageEndpoint ?? "")")
        let placeholderImage = UIImage(named: "AppIcon")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        self.kf.setImage(with: url, placeholder: placeholderImage)
    }
}
