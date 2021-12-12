//
//  PayWallHeaderView.swift
//  MuseApp
//
//  Created by Anton Veldanov on 12/11/21.
//

import UIKit

class PayWallHeaderView: UIView {

    
    // HeaderImage
    private let headerImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "lightbulb.fill"))
        imageView.frame = CGRect(x: 0, y: 0, width: 110, height: 110)
        imageView.tintColor = .systemYellow
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(headerImageView)
        if #available(iOS 15.0, *) {
            backgroundColor = .systemCyan
        } else {
            backgroundColor = .systemBlue
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerImageView.frame = CGRect(x: (bounds.width-110)/2, y: (bounds.height-110)/2, width: 110, height: 110)
    }
    
    
}
