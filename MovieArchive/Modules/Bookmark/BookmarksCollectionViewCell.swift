//
//  BookmarksCollectionViewCell.swift
//  MovieArchive
//
//  Created by Emre Çakır on 9.08.2023.
//

import UIKit

final class BookmarksCollectionViewCell: UICollectionViewCell {
    
    static let reusableIdentifier = "ListCollectionViewCell"
    
    private let movieImageView: UIImageView = {
        let movieImageView = UIImageView()
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.layer.cornerRadius = 12
        movieImageView.clipsToBounds = true
        movieImageView.layer.masksToBounds = true
        movieImageView.contentMode = .redraw
        return movieImageView
    }()
    
    private let movieTitleLabel: UILabel = {
      let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        label.textAlignment = .center
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
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            
            movieTitleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor),
            movieTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configureCell(movieModel: MovieDetailModel) {
        movieImageView.setImage(with: movieModel.posterPath, placeholder: "popcorn")
        movieTitleLabel.text = movieModel.title
    }

}