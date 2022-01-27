//
//  TabBarViewController.swift
//  MuseApp
//
//  Created by Anton Veldanov on 12/9/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupControllers()
    }
    
    private func setupControllers(){
        
        guard let currentUserEmail = UserDefaults.standard.string(forKey: "email") else{
            return
        }
        
        let homeVC = HomeViewController()
        let profileVC = ProfileViewController(currentEmail: currentUserEmail)
        
        homeVC.title = "Home"
        profileVC.title = "Profile"
        
        homeVC.navigationItem.largeTitleDisplayMode = .always
        profileVC.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: homeVC)
        let nav2 = UINavigationController(rootViewController: profileVC)

        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        
        tabBar.tintColor = .white
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 2)

        setViewControllers([nav1,nav2], animated: true)
    }
    



}
