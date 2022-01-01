//
//  PostHeaderTableViewCell.swift
//  MuseApp
//
//  Created by Anton Veldanov on 12/30/21.
//

import UIKit

class PostHeaderTableViewCellViewModel{
    let imageURL: URL?
    var imageData: Data?
    
    init(imageURL: URL?){
        self.imageURL = imageURL
    }
    
}



class PostHeaderTableViewCell: UITableViewCell {

    static let identifier = "PostHeaderTableViewCell"
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(postImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        postImageView.frame = contentView.bounds
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
        
    }
    
    func configureCell(with viewModel: PostHeaderTableViewCellViewModel){
        
        if let data = viewModel.imageData{
            postImageView.image = UIImage(data: data)
        }else if let url = viewModel.imageURL{
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
