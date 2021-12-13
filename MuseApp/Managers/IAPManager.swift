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
    // a55e6fb2cc8642e9a8f41f95be98c786
    func isPremium()->Bool{
        return UserDefaults.standard.bool(forKey: "premium")
    }
    
    public func getSubscriptionStatus(){
    }
    
    
    public func fetchPackages(completion: @escaping (Purchases.Package?)->Void){
        
    }
    public func subscribe(package: Purchases.Package){
        
    }
    
    public func restorePurchases(){
        
        
    }
    
}
