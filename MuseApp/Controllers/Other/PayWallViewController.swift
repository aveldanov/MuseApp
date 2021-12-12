//
//  PayWallViewController.swift
//  MuseApp
//
//  Created by Anton Veldanov on 12/11/21.
//

import UIKit

class PayWallViewController: UIViewController {
    
    private let header = PayWallHeaderView()

    
    //TODO:
    // Close button / Title
    

    
    // Pricing and produce
    // Call To Action(CTA) Buttons
    // Terms of Service
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(header)
        setupCloseButton()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        header.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.height/3.2)
    }
    
    
    private func setupCloseButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))

    }
    
    
    @objc private func didTapClose(){
        dismiss(animated: true, completion: nil)
    }
    


}
