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
        
    }
    
    
    public func getProfilePictureURL(user: User, completion: @escaping (URL?)->Void){
        
        
    }
    
    
    
    
    public func uploadBlogHeaderImage(blogPost: BlogPost, image: UIImage?, completion: @escaping (Bool)->Void){
        
    }
    
    
    
    public func getPostHeaderURL(blogPost: BlogPost, completion: @escaping (URL?)->Void){
        
        
    }
    
    
}

