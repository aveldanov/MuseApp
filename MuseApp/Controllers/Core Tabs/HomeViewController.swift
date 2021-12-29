//
//  ViewController.swift
//  MuseApp
//
//  Created by Anton Veldanov on 12/9/21.
//

import UIKit

class HomeViewController: UIViewController {

    
    private let composeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor  = .systemBlue
        button.tintColor = .white
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.layer.cornerRadius = 40
        button.layer.shadowColor = UIColor.label.cgColor
        button.layer.shadowOpacity = 0.4
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

    }

    
    

}

