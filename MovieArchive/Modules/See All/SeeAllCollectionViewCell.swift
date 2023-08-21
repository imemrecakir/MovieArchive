//
//  SeeAllCollectionViewCell.swift
//  MovieArchive
//
//  Created by Emre Çakır on 18.08.2023.
//

import UIKit

final class SeeAllCollectionViewCell: UICollectionViewCell {
    
    static let reusableIdentifier = "SeeAllCollectionViewCell"
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .redraw
        imageView.layer.borderColor = UIColor.secondarySystemFill.cgColor
        imageView.layer.borderWidth = 0.5
        return imageView
    }()
    
    private let movieTitleLabel: UILabel = {
      let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    func configureCell(movieModel: MovieResultModel) {
        movieImageView.setImage(with: movieModel.posterPath)
        movieTitleLabel.text = movieModel.title
    }
}
