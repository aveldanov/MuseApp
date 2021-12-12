//
//  IAPManager.swift
//  MuseApp
//
//  Created by Anton Veldanov on 12/9/21.
//

import Foundation
import Purchases

final class IAPManager{
    
    static let shared = IAPManager()
    private init(){}
    
    func isPremium()->Bool{
        return false //for now
    }
    
    func subscribe(){
        
    }
    
    func restorePurchases(){
        
        
    }
    
}
