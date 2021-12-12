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
    
    
    public func insert(with blogPost: BlogPost, user: User, completion: @escaping (Bool)->Void){
        
        
    }
    
    public func getAllPosts(completion: @escaping ([BlogPost])->Void){
        
        
    }
    
    
    public func getPosts(for user: User, completion: @escaping ([BlogPost])->Void){
        
        
    }
    
    public func insertUser(user: User, completion: @escaping (Bool)->Void){
        
        
    }
    
    
    
}

