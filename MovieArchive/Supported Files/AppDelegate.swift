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
        setTabBarStyle()
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
    
    func setNavigationBarStyle() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        let backButtonImage = UIImage(systemName: "arrow.left.circle")?
            .withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -6, bottom: -2, right: 0))
        
        appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        appearance.backButtonAppearance.configureWithDefault(for: .plain)
        appearance.backButtonAppearance.accessibilityFrame.size = CGSize(width: 30, height: 40)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    func setTabBarStyle() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
}

