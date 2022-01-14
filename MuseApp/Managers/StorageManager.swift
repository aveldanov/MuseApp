//
//  StorageManager.swift
//  MuseApp
//
//  Created by Anton Veldanov on 12/9/21.
//

import Foundation
import Firebase


final class StorageManager{
    static let shared = StorageManager()
    private init(){}
    private let container = Storage.storage()
    
    
    public func uploadUserProfilePicture(email: String, image: UIImage?, completion: @escaping (Bool)->Void){
        let path = email
            .replacingOccurrences(of: "@", with: "_")
            .replacingOccurrences(of: ".", with: "_")
        guard let pngData = image?.pngData() else{
            return
        }
        
        container
            .reference(withPath: "profile_pictures/\(path)/photo.png")
            .putData(pngData, metadata: nil) { metadata, error in
                guard metadata != nil, error == nil else{
                    completion(false)
                    return
                }
                completion(true)
            }
    }
    
    
    public func getProfilePictureURL(path: String, completion: @escaping (URL?)->Void){
        
        container.reference(withPath: path)
            .downloadURL { url, error in
                completion(url)
            }
    }
    
    
    
    
    public func uploadBlogHeaderImage(email: String, image: UIImage, postId: String, completion: @escaping (Bool)->Void){
        
        let path = email
            .replacingOccurrences(of: "@", with: "_")
            .replacingOccurrences(of: ".", with: "_")
        guard let pngData = image.pngData() else{
            return
        }
        
        container
            .reference(withPath: "post_headers/\(path)/\(postId).png")
            .putData(pngData, metadata: nil) { metadata, error in
                guard metadata != nil, error == nil else{
                    completion(false)
                    return
                }
                completion(true)
            }
    }
    
    
    public func getPostHeaderURL(email: String, postId: String, completion: @escaping (URL?)->Void){
        
        
        let emailComponent = email
            .replacingOccurrences(of: "@", with: "_")
            .replacingOccurrences(of: ".", with: "_")

        
        container
            .reference(withPath: "post_headers/\(emailComponent)/\(postId).png")
            .downloadURL { url, error in
                completion(url)
            }
    }
}

