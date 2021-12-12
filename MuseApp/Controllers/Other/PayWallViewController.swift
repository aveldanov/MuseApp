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
    
    private let buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Subscribe", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private let restoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Restore Purchases", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    // Terms of Service
    
    private let termsView: UITextView = {
        let textView = UITextView() // use TextView so it can be scrollable vs Label
        textView.textAlignment = .center
        textView.font = .systemFont(ofSize: 14)
        textView.isEditable = false
        textView.textColor = .secondaryLabel
        textView.text = "This is an auto-renewable Subscription. You will be charged before each pay period. You can cancel anytime by going into your Settings -> Subscriptions. Restore Purchases if previously subscribed."
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Muse Premium"
        view.backgroundColor = .systemBackground
        view.addSubview(header)
        view.addSubview(buyButton)
        view.addSubview(restoreButton)
        view.addSubview(termsView)
        setupCloseButton()
        setupButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        header.frame = CGRect(x: 0,
                              y: view.safeAreaInsets.top,
                              width: view.width,
                              height: view.height/3.2)
        
        termsView.frame = CGRect(x: 10,
                                 y: view.height-100,
                                 width: view.width-20,
                                 height: 100)
        
        buyButton.frame = CGRect(x: 25,
                                 y: restoreButton.top-60,
                                 width: view.width-50,
                                 height: 50)
        
        restoreButton.frame = CGRect(x: 25,
                                     y: termsView.top-70,
                                     width: view.width-50,
                                     height: 50)
    }
    
    private func setupCloseButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
    }
    
    private func setupButtons(){
        buyButton.addTarget(self, action: #selector(didTapSubscribe), for: .touchUpInside)
        restoreButton.addTarget(self, action: #selector(didTapRestore), for: .touchUpInside)
    }
    
    
    @objc private func didTapSubscribe(){
        //revenueCat
    }
    
    @objc private func didTapRestore(){
        //revenueCat
    }

    @objc private func didTapClose(){
        dismiss(animated: true, completion: nil)
    }
    


}
