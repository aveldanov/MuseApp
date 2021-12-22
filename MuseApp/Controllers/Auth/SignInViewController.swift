//
//  SignInViewController.swift
//  MuseApp
//
//  Created by Anton Veldanov on 12/9/21.
//

import UIKit

class SignInViewController: UIViewController {

    // Header View
    private let headerView = SignInHeaderView()
    
    // Email Field
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.keyboardType = .emailAddress
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        
        return field
    }()
    
    // password field
    
    // Sign in button
    
    // Create accoutn button
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Sign In"
        view.backgroundColor = .systemBackground
        view.addSubview(headerView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.height/5)
    }


}
