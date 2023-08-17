//
//  ListHeaderView.swift
//  MovieArchive
//
//  Created by Emre Çakır on 30.07.2023.
//

import UIKit

final class ListHeaderView: UICollectionReusableView {
    static let reusableIdentifier = "ListHeaderView"
    
    var completion: (() -> Void)?
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Category"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private lazy var seeAllButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textColor = .yellow
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.setTitleColor(.quaternaryLabel, for: .highlighted)
        button.setTitle("See All", for: .normal)
        button.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        return button
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
        addSubview(headerLabel)
        addSubview(seeAllButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: seeAllButton.leadingAnchor, constant: -10),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            seeAllButton.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            seeAllButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    func configureHeader(headerTitle: String) {
        headerLabel.text = headerTitle
    }
    
    @objc private func seeAllButtonTapped() {
        completion?()
    }
}
