//
//  MovieTableViewCell.swift
//  MovieArchive
//
//  Created by Emre Çakır on 13.08.2023.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    static let reusableIdentifier = "MovieTableViewCell"
    
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(systemName: "popcorn")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private lazy var infoStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [titleLabel, dateLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let accessoryImageView: UIImageView = {
        return UIImageView(image: UIImage(systemName: "chevron.forward")?.withTintColor(.secondaryLabel, renderingMode: .alwaysOriginal))
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(movieImageView)
        addSubview(infoStackView)
        accessoryView = accessoryImageView
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            movieImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            movieImageView.widthAnchor.constraint(equalToConstant: 100),
            
            infoStackView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
//            infoStackView.topAnchor.constraint(equalTo: topAnchor),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            infoStackView.centerYAnchor.constraint(equalTo: movieImageView.centerYAnchor)
        ])
    }
    
    func configure(movie: MovieResultModel) {
        movieImageView.setImage(with: movie.posterPath)
        titleLabel.text = movie.title
        dateLabel.text = movie.releaseDate.dateFormatted()
    }
}
