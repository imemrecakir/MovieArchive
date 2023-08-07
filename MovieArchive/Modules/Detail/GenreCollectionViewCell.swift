//
//  GenreView.swift
//  MovieArchive
//
//  Created by Emre Çakır on 6.08.2023.
//

import UIKit

final class GenreCollectionViewCell: UICollectionViewCell {
    
    static let reusableIdentifier = "GenreCollectionViewCell"
   
    private let titleLabel: UILabel = {
      let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .monospacedSystemFont(ofSize: label.font.pointSize, weight: .regular)
        label.textColor = .label
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
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }

    func configureCell(genreName: String) {
        titleLabel.text = genreName
    }
}
