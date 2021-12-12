//
//  ViewController.swift
//  MuseApp
//
//  Created by Anton Veldanov on 12/9/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            if !IAPManager.shared.isPremium(){
                let vc = PayWallViewController()
                self.present(vc, animated: true, completion: nil)
            }
        }
    }


}

