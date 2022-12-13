//
//  AddViewModel.swift
//  Quotex33
//
//  Created by Вячеслав on 12/13/22.
//

import SwiftUI
import Firebase

final class AddViewModel: ObservableObject {
    
    @Published var isLoading = false
    
    @Published var types: [String] = ["Income", "Cost"]
    @Published var type: String = ""
    
    @Published var categories: [String] = ["Food", "Clothes", "Travel", "Home", "Car", "Tech", "Fun", "Sport", "Gasoline"]
    @Published var category: String = ""
    
    @Published var sum: String = ""
    
    let ref = Firestore.firestore()
    
    @Published var deviceID = UIDevice.current.identifierForVendor!.uuidString
    
    public func cleanFields() {
        
        type = ""
        category = ""
        sum = ""
    }
    
    public func addHistory(account: MyAccountsModel){
        
        withAnimation(.spring()){
            
            isLoading = true
        }
        
        let randomID = Int.random(in: 1...99999)
        
        self.ref.collection("Devices").document("\(deviceID)").collection("Currencies").document(account.name).collection("History").document("\(randomID)").setData([
        
            "type": type,
            "currency": account.currency,
            "category": category,
            "sum": Int(sum) ?? 0,
            "created": Timestamp(date: Date()),
        
        ]) { (err) in

            if err != nil{

                self.isLoading = false
                
                return
            }
            
            self.isLoading = false
            
            self.type = ""
            self.category = ""
            self.sum = ""
        }
    }
    
    public func updateCountCurrency(account: MyAccountsModel){
        
        withAnimation(.spring()){
            
            isLoading = true
        }
        
        let total = account.totalMoney + (Int(sum) ?? 0)
        
        self.ref.collection("Devices").document("\(deviceID)").collection("Currencies").document(account.name).updateData([
        
            "money": total,
        
        ]) { (err) in

            if err != nil{

                self.isLoading = false
                
                return
            }
            
            self.isLoading = false
        }
    }
}
