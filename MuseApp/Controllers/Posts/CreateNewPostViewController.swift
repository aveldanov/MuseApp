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
        
    }

    @objc private func didTapPost(){
        
    }

}
