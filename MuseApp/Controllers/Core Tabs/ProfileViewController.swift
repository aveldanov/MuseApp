//
//  ProfileViewController.swift
//  MuseApp
//
//  Created by Anton Veldanov on 12/9/21.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSignOut))
    }
    
    @objc private func didTapSignOut(){
        AuthManager.shared.signOut { [weak self] success in
            if success{
                DispatchQueue.main.async {
                    let signinVC = SignInViewController()
                    signinVC.navigationItem.largeTitleDisplayMode = .always
                    
                    let navVC = UINavigationController(rootViewController: signinVC)
                    navVC.navigationBar.prefersLargeTitles = true
                    navVC.modalPresentationStyle = .fullScreen
                    self?.present(navVC, animated: true, completion: nil)
                }
            }
        }
        
    }
 

}
