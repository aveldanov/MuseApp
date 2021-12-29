//
//  CreateNewPostViewController.swift
//  MuseApp
//
//  Created by Anton Veldanov on 12/9/21.
//

import UIKit

class CreateNewPostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureButtons()
    }
    
    
    private func configureButtons(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapPost))
    }
    
    
    @objc private func didTapCancel(){
        dismiss(animated: true, completion: nil)
    }

    @objc private func didTapPost(){
        // check data and make a post
        
        
    }

}
