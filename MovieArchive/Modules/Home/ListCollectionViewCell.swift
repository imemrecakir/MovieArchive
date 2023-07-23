//
//  ListTableViewCell.swift
//  MovieArchive
//
//  Created by Emre Çakır on 23.07.2023.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {

    static let reusableIdentifier = "ListCollectionViewCell"
    
    private let infoStackView: UIStackView = {
        let infoStackView = UIStackView()
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.axis = .horizontal
        infoStackView.distribution = .fillEqually
        return infoStackView
    }()
    
    private let releaseDateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.textAlignment = .center
        return label
    }()
    
    private let languageLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.textAlignment = .center
        return label
    }()
    
    private let adultImageView: UIImageView = {
        let movieImage = UIImage(systemName: "popcorn")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let movieImageView = UIImageView()
        movieImageView.image = movieImage
        movieImageView.contentMode = .scaleAspectFit
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.backgroundColor = .purple
        return movieImageView
    }()
    
    private let movieImageView: UIImageView = {
        let movieImage = UIImage(systemName: "popcorn")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let movieImageView = UIImageView()
        movieImageView.image = movieImage
        movieImageView.contentMode = .scaleAspectFit
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        return movieImageView
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.textAlignment = .center
        return label
    }()
    
    private let overviewLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .gray
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -5),
            movieImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height - 20),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func configureCell(movieModel: MovieResultModel) {
//        titleLabel.text = movieModel.title
//    }
}
