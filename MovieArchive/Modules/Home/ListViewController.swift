//
//  ListViewController.swift
//  MovieArchive
//
//  Created by Emre Çakır on 23.07.2023.
//

import UIKit

final class ListViewController: UIViewController {
    
    private let viewModel: ListViewModel
    
    private lazy var listCollectionView: UICollectionView = {
        let layout = createCompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ListHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ListHeaderView.reusableIdentifier)
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.reusableIdentifier)
        return collectionView
    }()
    
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
        
        viewModel.fetchNowPlayingMovies()
        viewModel.fetchPopularMovies()
        viewModel.fetchTopRatedMovies()
        viewModel.fetchUpcomingMovies()
        //        viewModel.fetchMoviesByGenres(genre: GenreModel(id: 18, name: "Action"))
        //        viewModel.fetchMoviesByGenres(genre: GenreModel(id: 12, name: "Adventure"))
        //        viewModel.fetchGenres()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.addSubview(listCollectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            listCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] (sectionNumber, env) -> NSCollectionLayoutSection? in
            switch sectionNumber {
            case 0: return self?.getNowPlayingLayoutSection()
            case 1: return self?.getPopularLayoutSection()
            case 2: return self?.getTopRatedLayoutSection()
            default: return self?.getUpcomingLayoutSection()
            }
        }
    }
    
    private func getNowPlayingLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.75))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 16, leading: 16, bottom: 0, trailing: 16)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }
    
    private func getPopularLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.50), heightDimension: .fractionalWidth(0.50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 16, leading: 0, bottom: 0, trailing: 16)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        return section
    }
    
    private func getTopRatedLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.50), heightDimension: .fractionalWidth(0.50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 16, leading: 0, bottom: 0, trailing: 16)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        return section
    }
    
    private func getUpcomingLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.50), heightDimension: .fractionalWidth(0.50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 16, leading: 0, bottom: 0, trailing: 16)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    @objc private func filterTapped() {
        print("Filter Tapped")
    }
}

extension ListViewController: ListViewModelDelegate {
    func nowPlayingMoviesFetched() {
        if viewModel.error != nil && viewModel.nowPlayingMovies.isEmpty {
            print("Error - \(String(describing: viewModel.error.debugDescription))")
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.listCollectionView.reloadData()
            }
        }
    }
    
    func popularMoviesFetched() {
        if viewModel.error != nil && viewModel.popularMovies.isEmpty {
            print("Error - \(String(describing: viewModel.error.debugDescription))")
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.listCollectionView.reloadData()
            }
        }
    }
    
    func topRatedMoviesFetched() {
        if viewModel.error != nil && viewModel.topRatedMovies.isEmpty {
            print("Error - \(String(describing: viewModel.error.debugDescription))")
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.listCollectionView.reloadData()
            }
        }
    }
    
    func upcomingMoviesFetched() {
        if viewModel.error != nil && viewModel.upcomingMovies.isEmpty {
            print("Error - \(String(describing: viewModel.error.debugDescription))")
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.listCollectionView.reloadData()
            }
        }
    }
    
    func isLoading(_ state: Bool) {
        print("isLoading : \(state)")
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ListHeaderView.reusableIdentifier, for: indexPath) as? ListHeaderView {
            headerView.configureHeader(headerTitle: viewModel.categoryList[indexPath.section])
            return headerView
        }
        
        return UICollectionReusableView()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return viewModel.nowPlayingMovies.count
        case 1: return viewModel.popularMovies.count
        case 2: return viewModel.topRatedMovies.count
        case 3: return viewModel.upcomingMovies.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.reusableIdentifier, for: indexPath) as? ListCollectionViewCell {
            
            switch indexPath.section {
            case 0:
                cell.configureCell(movieModel: viewModel.nowPlayingMovies[indexPath.item])
                break
            case 1:
                cell.configureCell(movieModel: viewModel.popularMovies[indexPath.item])
                break
            case 2:
                cell.configureCell(movieModel: viewModel.topRatedMovies[indexPath.item])
                break
            case 3:
                cell.configureCell(movieModel: viewModel.upcomingMovies[indexPath.item])
                break
            default: break
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}
