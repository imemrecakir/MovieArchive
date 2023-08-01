//
//  TabBarViewController.swift
//  MovieArchive
//
//  Created by Emre Çakır on 23.07.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    private let seperator: CALayer = {
        let seperator = CALayer()
        seperator.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 1)
        seperator.backgroundColor = UIColor.opaqueSeparator.cgColor
        return seperator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .label
        tabBar.unselectedItemTintColor = .tertiaryLabel
        tabBar.layer.addSublayer(seperator)
        setupTabs()
    }
    
    private func setupTabs() {
        setViewControllers([
            createViewController(tabViewController: ListViewController(viewModel: ListViewModel()),
                                 title: "List",
                                 defaultImage: "house",
                                 selectedImage: "house.fill"),
            createViewController(tabViewController: DiscoverViewController(viewModel: DiscoverViewModel()),
                                 title: "Discover",
                                 defaultImage: "square.grid.2x2",
                                 selectedImage: "square.grid.2x2.fill"),
            createViewController(tabViewController: BookmarksViewController(viewModel: BookmarksViewModel()),
                                 title: "Bookmarks",
                                 defaultImage: "bookmark",
                                 selectedImage: "bookmark.fill"),
        ], animated: true)
    }
    
    private func createViewController(tabViewController: UIViewController, title: String, defaultImage: String, selectedImage: String) -> UINavigationController {
        tabViewController.view.backgroundColor = .secondarySystemBackground
        let navigationController = UINavigationController(rootViewController: tabViewController)
        navigationController.navigationBar.isHidden = true
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = UIImage(systemName: defaultImage)
        navigationController.tabBarItem.selectedImage = UIImage(systemName: selectedImage)
        return navigationController
    }
}
