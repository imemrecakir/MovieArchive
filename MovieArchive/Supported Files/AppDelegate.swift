//
//  AppDelegate.swift
//  MovieArchive
//
//  Created by Emre Çakır on 23.07.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setNavigationBarStyle()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}

    func setNavigationBarStyle() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        let backButtonImage = UIImage(systemName: "arrow.left.circle")?
            .withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -6, bottom: -2, right: 0))

        appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        appearance.backButtonAppearance.configureWithDefault(for: .plain)
        appearance.backButtonAppearance.accessibilityFrame.size = CGSize(width: 20, height: 40)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//        lazy var bookmarkImageView: UIImageView = {
//            let imageView = UIImageView()
//            imageView.translatesAutoresizingMaskIntoConstraints = false
//            imageView.image = UIImage(systemName: "bookmark.square")?.withTintColor(.label, renderingMode: .alwaysOriginal)
//            imageView.contentMode = .scaleToFill
//            imageView.backgroundColor = .secondarySystemBackground
//            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bookmarkNavBarItemTapped)))
//            return imageView
//        }()
//
//        UINavigationItem().leftBarButtonItem = UIBarButtonItem(customView: bookmarkImageView)
    }
    
    @objc private func bookmarkNavBarItemTapped() {
        print("Selamlaar")
    }
}

