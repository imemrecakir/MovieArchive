//
//  ListTableViewCell.swift
//  MovieArchive
//
//  Created by Emre Çakır on 23.07.2023.
//

import UIKit
import Foundation

final class ListCollectionViewCell: UICollectionViewCell {
    
    static let reusableIdentifier = "ListCollectionViewCell"
    
    private let movieImageView: UIImageView = {
        let movieImageView = UIImageView()
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.clipsToBounds = true
        movieImageView.image = UIImage(systemName: "popcorn")
        movieImageView.layer.cornerRadius = 24
        return movieImageView
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title (2022)"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieTitleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            movieImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            
            movieTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            movieTitleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor),
            movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            movieTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configureCell(movieModel: MovieResultModel) {
        movieTitleLabel.text = movieModel.title
        movieImageView.setImage(with: movieModel.backdropPath, placeholder: "popcorn")
    }
}
