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
    private let storage = Storage.storage()
    
    
    public func insertBlogPost(with post: String, user: String, completion: @escaping (Bool)->Void){
        
        
    }
}

