//
//  CreateNewPostViewController.swift
//  MuseApp
//
//  Created by Anton Veldanov on 12/9/21.
//

import UIKit
import PhotosUI

class CreateNewPostViewController: UIViewController {

    // title field
    
    private let postTitleField: UITextField = {
        let field = UITextField()
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.placeholder = "Enter title..."
        field.autocapitalizationType = .words
        field.autocorrectionType = .yes
        field.backgroundColor = .secondarySystemBackground
        field.layer.masksToBounds = true
        return field
    }()
    
    // image
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "photo")
        imageView.backgroundColor = .tertiarySystemBackground
        
        return imageView
    }()
    
    // textview for post
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .secondarySystemBackground
        textView.isEditable = true
        textView.font = .systemFont(ofSize: 28)
        return textView
    }()
    
    
    private var selectedHeaderImage: UIImage?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(postTitleField)
        view.addSubview(headerImageView)
        view.addSubview(textView)

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapHeader))
        headerImageView.addGestureRecognizer(tap)
        configureButtons()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        postTitleField.frame = CGRect(x: 10, y: view.safeAreaInsets.top, width: view.width-20, height: 50)
        headerImageView.frame = CGRect(x: 0, y: postTitleField.bottom+5, width: view.width, height: 160)
        textView.frame = CGRect(x: 10, y: headerImageView.bottom+10, width: view.width-20, height: view.height-210-view.safeAreaInsets.top)
        
    }
    
    
    
    @objc private func didTapHeader(){
        if #available(iOS 14, *) {
            let config = PHPickerConfiguration()
            let picker = PHPickerViewController(configuration: config)
            picker.delegate = self
            print("YO WORKED")
            present(picker, animated: true, completion: nil)

        } else {
            // Fallback on earlier versions
            let picker = UIImagePickerController()
            picker.sourceType  = .photoLibrary
            picker.delegate = self
            print("NOPE WORKED")

            present(picker, animated: true, completion: nil)
        }
        
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
        
        guard let title = postTitleField.text,
              let body = textView.text,
              let headerImage = selectedHeaderImage,
              let email = UserDefaults.standard.string(forKey: "email"),
              !title.trimmingCharacters(in: .whitespaces).isEmpty,
              !body.trimmingCharacters(in: .whitespaces).isEmpty else{
                  
                  let alert = UIAlertController(title: "Enter Post Details", message: "Add title, body, and upload an image to continue", preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                  
                  present(alert, animated: true, completion: nil)
                  return
              }
        // Upload header image
        let newPostId = UUID().uuidString
        StorageManager.shared.uploadBlogHeaderImage(email: email,
                                                    image: headerImage,
                                                    postId: newPostId) { success in
            guard success else{
                return
            }
            
            StorageManager.shared.getPostHeaderURL(email: email,
                                                   postId: newPostId) { url in
                guard let headerUrl = url else {
                    print("Failed to upload URL for header")
                    return
                }
                
                // Insert Post to DB
                let post = BlogPost(id: newPostId,
                                    title: title,
                                    timestamp: Date().timeIntervalSince1970,
                                    headerImageURL: headerUrl,
                                    text: body)
                
                DatabaseManager.shared.insert(blogPost: post, email: email) {[weak self] posted in
                    guard posted else{
                        print("Failed to post new Blog Article")
                        return
                    }
                
                    self?.didTapCancel()
                    
                }

            }
            
        }
        
        

        
    }

}


extension CreateNewPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else{
            return
        }
        
        selectedHeaderImage = image
        headerImageView.image = image
    }
    
}


@available(iOS 14, *)
extension CreateNewPostViewController: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true, completion: nil)

        let itemProviders = results.map(\.itemProvider)
        for item in itemProviders {
            if item.canLoadObject(ofClass: UIImage.self) {
                item.loadObject(ofClass: UIImage.self) { (image, error) in
                    DispatchQueue.main.async {
                        if let image = image as? UIImage {
                            self.selectedHeaderImage = image
                            self.headerImageView.image = image
                        }
                    }
                }
            }
        }

    }
    
    
    
    
}
