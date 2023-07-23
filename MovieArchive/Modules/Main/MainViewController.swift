//
//  MainViewController.swift
//  MovieArchive
//
//  Created by Emre Çakır on 23.07.2023.
//

import UIKit

class MainViewController: UITabBarController {
    
    let seperator: CALayer = {
        let seperator = CALayer()
        seperator.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 0.5)
        seperator.backgroundColor = UIColor.systemGray5.cgColor
        return seperator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .systemGray2
        tabBar.layer.addSublayer(seperator)
        viewControllers = [
            setupViewController(tabViewController: ListViewController(),
                                title: "List",
                                image: "house"),
            setupViewController(tabViewController: BookmarksViewController(),
                                title: "Bookmarks",
                                image: "bookmark"),
        ]
    }
    
    private func setupViewController(tabViewController: UIViewController, title: String, image: String) -> UINavigationController {
        tabViewController.tabBarItem.image = UIImage(systemName: image)
        tabViewController.title = title
        return UINavigationController(rootViewController: tabViewController)
    }
}
