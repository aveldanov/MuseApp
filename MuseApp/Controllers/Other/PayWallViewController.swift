//
//  PayWallViewController.swift
//  MuseApp
//
//  Created by Anton Veldanov on 12/11/21.
//

import UIKit

class PayWallViewController: UIViewController {
    //TODO:
    // Close button / Title
    

    
    // Pricing and produce
    // Call To Action(CTA) Buttons
    // Terms of Service
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    
    private func setupCloseButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))

    }
    
    
    @objc private func didTapClose(){
        dismiss(animated: true, completion: nil)
    }
    


}
