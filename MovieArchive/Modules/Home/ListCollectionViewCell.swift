//
//  ListTableViewCell.swift
//  MovieArchive
//
//  Created by Emre Çakır on 23.07.2023.
//

import UIKit

final class ListCollectionViewCell: UICollectionViewCell {
    
    static let reusableIdentifier = "ListCollectionViewCell"
    
    private let movieImageView: UIImageView = {
        let movieImage = UIImage(systemName: "popcorn")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        let movieImageView = UIImageView()
        movieImageView.image = movieImage
        movieImageView.contentMode = .scaleAspectFit
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
//        movieImageView.backgroundColor = .purple
        movieImageView.layer.cornerRadius = 24
        movieImageView.clipsToBounds = true
        return movieImageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title (2022)"
        label.textAlignment = .left
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
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    func configureCell(movieModel: MovieResultModel) {
        titleLabel.text = movieModel.title
    }
}
