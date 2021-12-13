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
    
    public func getSubscriptionStatus(completion: ((Bool)->Void)?){
        Purchases.shared.purchaserInfo { info, error in
            guard let entitlements = info?.entitlements, error == nil else{
                return
            }
            //checking if subscribed (entitled for Premium)
            if entitlements.all["Premium"]?.isActive == true{
                print("[IAPManager] Got update Status of Subscribed")
                UserDefaults.standard.set(true, forKey: "premium")
                completion?(true)
            }else{
                print("[IAPManager] Got update Status of NOT Subscribed")
                UserDefaults.standard.set(false, forKey: "premium")
                completion?(false)
            }
        
        }
    }
    
    
    public func fetchPackages(completion: @escaping (Purchases.Package?)->Void){
        Purchases.shared.offerings { offerings, error in
            guard let package = offerings?.offering(identifier: "default")?.availablePackages.first, error == nil else{
                completion(nil)
                return
            }
            completion(package)
        }
    }
    
    public func subscribe(package: Purchases.Package, completion: @escaping (Bool)->Void){
        guard !isPremium() else{
            print("[IAPManager] User already subscribed")
            completion(true)
            return
        }
        
        Purchases.shared.purchasePackage(package) { transaction, info, error, userCancelledTransaction in
            guard let transaction = transaction, let entitlements = info?.entitlements, error == nil, !userCancelledTransaction else{
                return
            }
            
            switch transaction.transactionState{
                
            case .purchasing:
                print("purchasing")
            case .purchased:
                print("purchased \(entitlements)")
                //checking if subscribed (entitled for Premium)
                if entitlements.all["Premium"]?.isActive == true{
                    print("[IAPManager] Purchased")
                    UserDefaults.standard.set(true, forKey: "premium")
                    completion(true)
                }else{
                    print("[IAPManager] Purchase failed")
                    UserDefaults.standard.set(false, forKey: "premium")
                    completion(false)
                }
            case .failed:
                print("failed")

            case .restored:
                print("restored")

            case .deferred:
                print("deferred")

            @unknown default:
                print("default")

            }
        }
    }
    
    public func restorePurchases(completion: @escaping (Bool)->Void){
        Purchases.shared.restoreTransactions  { info, error in
            guard let entitlements = info?.entitlements, error == nil else{
                return
            }
            
        print("Restored \(entitlements) ")
            
            if entitlements.all["Premium"]?.isActive == true{
                print("[IAPManager] Restored")
                UserDefaults.standard.set(true, forKey: "premium")
                completion(true)
            }else{
                print("[IAPManager] Restore failed")
                UserDefaults.standard.set(false, forKey: "premium")
                completion(false)
            }
            
        }
        
    }
    
}
