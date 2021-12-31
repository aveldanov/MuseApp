//
//  PostPreviewTableViewCell.swift
//  MuseApp
//
//  Created by Anton Veldanov on 12/30/21.
//

import UIKit


class PostPreviewTableViewCellViewModel{
    let title: String
    let imageUrl: URL?
    var imageData: Data?
    
    init(title: String, imageUrl: URL?){
        self.title = title
        self.imageUrl = imageUrl
    }
    
    
}

class PostPreviewTableViewCell: UITableViewCell {

    static let identifier = "PostHeaderTableViewCell"
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let postTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(postImageView)
        contentView.addSubview(postTitleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        postImageView.frame = CGRect(x: separatorInset.left,
                                      y: 5,
                                      width: contentView.height-10,
                                      height: contentView.height-10)
        
        postTitleLabel.frame = CGRect(x: postImageView.right+5,
                                      y: 5,
                                      width: contentView.width-5-separatorInset.left-postImageView.width,
                                      height: contentView.height-10)
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postTitleLabel.text = nil
        postImageView.image = nil
        
    }
    
    func configureCell(with viewModel: PostPreviewTableViewCellViewModel){
        postTitleLabel.text = viewModel.title
        
        if let data = viewModel.imageData{
            postImageView.image = UIImage(data: data)
        }else if let url = viewModel.imageUrl{
            //Fetch image and cache it
            URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                //caching as part of VM
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.postImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    
}