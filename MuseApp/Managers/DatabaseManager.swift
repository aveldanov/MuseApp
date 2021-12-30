//
//  DataBaseManager.swift
//  MuseApp
//
//  Created by Anton Veldanov on 12/9/21.
//

import Foundation
import Firebase


final class DatabaseManager{
    static let shared = DatabaseManager()
    private init(){}
    private let database = Firestore.firestore()
    
    
    public func insert(blogPost: BlogPost, email: String, completion: @escaping (Bool)->Void){
        let userEmail = email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")
        
        let data:[String: Any] = [
            "id": blogPost.id,
            "title": blogPost.title,
            "body": blogPost.text,
            "createdOn": blogPost.timestamp,
            "headerImageUrl": blogPost.headerImageURL?.absoluteString ?? ""
        ]
        
        database
            .collection("users")
            .document(userEmail)
            .collection("posts")
            .addDocument(data: data) { error in
                completion(error == nil)
            }
        
      
    }
    
    public func getAllPosts(completion: @escaping ([BlogPost])->Void){
        
        
    }
    
    
    public func getPosts(for user: User, completion: @escaping ([BlogPost])->Void){
        
        
    }
    
    public func insertUser(user: User, completion: @escaping (Bool)->Void){
        let documentID = user.email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")
        
        let data = [
            "email": user.email,
            "name": user.name
        ]
        database
            .collection("users")
            .document(documentID)
            .setData(data) { error in
                completion(error == nil)
            }
        
    }
    
    
    public func getUser(email: String, completion: @escaping (User?)->Void){
        let documentID = email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")
        
        database
            .collection("users")
            .document(documentID)
            .getDocument { snapshot, error in
                guard let data = snapshot?.data() as? [String: String], let name = data["name"], error == nil else{
                    return
                }
                
                let ref = data["profile_photo"]
             
                
                let user = User(name: name, email: email, profilePictureUrlReference: ref)
                
                 completion(user)
            }
        
        
    }
    
    func updateProfilePhoto(email: String, completion: @escaping (Bool)->Void){
        let path = email
            .replacingOccurrences(of: "@", with: "_")
            .replacingOccurrences(of: ".", with: "_")
        let photoReference = "profile_pictures/\(path)/photo.png"
        
        let dbRef = database
            .collection("users")
            .document(path)

        dbRef.getDocument { snapshot, error in
            guard var data = snapshot?.data(), error == nil else{
                return
            }
            data["profile_photo"] = photoReference
            dbRef.setData(data) { error in
                completion(error == nil)
            }
        }
    }
    
}

