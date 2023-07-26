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
        tabBar.unselectedItemTintColor = .secondaryLabel
        tabBar.layer.addSublayer(seperator)
        setupTabs()
    }
    
    private func setupTabs() {
        setViewControllers([
            createViewController(tabViewController: ListViewController(),
                                 title: "List",
                                 image: "house"),
            createViewController(tabViewController: BookmarksViewController(),
                                 title: "Bookmarks",
                                 image: "bookmark"),
        ], animated: true)
    }
    
    private func createViewController(tabViewController: UIViewController, title: String, image: String) -> UINavigationController {
        tabViewController.view.backgroundColor = .systemBackground
        let navigationController = UINavigationController(rootViewController: tabViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = UIImage(systemName: image)
        return navigationController
    }
}
