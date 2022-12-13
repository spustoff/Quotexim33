//
//  MyAccountsViewModel.swift
//  Quotex33
//
//  Created by Вячеслав on 12/12/22.
//

import SwiftUI
import Firebase

final class MyAccountsViewModel: ObservableObject {
    
    @Published var currencies: [MyAccountsModel] = []
    @Published var selectedAccount: MyAccountsModel? = MyAccountsModel(currencyID: 0, currency: "", totalMoney: 0, name: "")
    
    @Published var selectedCurrency: MyAccountsModel = MyAccountsModel(currencyID: 0, currency: "", totalMoney: 0, name: "")
    
    @Published var showNewAccount: Bool = false
    @Published var showAdding: Bool = false
    
    @Published var isLoading = false
    
    let ref = Firestore.firestore()
    
    @Published var deviceID = UIDevice.current.identifierForVendor!.uuidString
    @Environment(\.presentationMode) var presentationMode
    
    init() {
        
        getCurrencies()
    }
    
    public func getCurrencies(){
        
        withAnimation(.spring()){

            self.isLoading = true
        }

        self.ref.collection("Devices").document("\(deviceID)").collection("Currencies").addSnapshotListener { (QuerySnapshot, error) in

            guard let docs = QuerySnapshot else {
                
                self.isLoading = false
                
                return
                
            }
            
            if docs.documentChanges.isEmpty {
            
                self.isLoading = false
                
                return
            }
            
            docs.documentChanges.forEach { (doc) in
                
                if doc.type == .added{
                    
                    let currencyID = doc.document.data()["currencyID"] as? Int ?? 0
                    
                    let currency = doc.document.data()["currency"] as? String ?? ""
                    let money = doc.document.data()["money"] as? Int ?? 0
                    let name = doc.document.data()["name"] as? String ?? ""

                    self.currencies.append(MyAccountsModel(currencyID: currencyID, currency: currency, totalMoney: money, name: name))
                    
                    if !self.currencies.isEmpty {
                        
                        self.selectedCurrency = self.currencies.first!
                    }
                }
                
                if doc.type == .removed{

                    let currencyID = doc.document.data()["currencyID"] as? Int ?? 0

                    self.currencies.removeAll { (post) -> Bool in

                        return post.currencyID == currencyID
                    }
                    
                    if !self.currencies.isEmpty {
                        
                        self.selectedCurrency = self.currencies.first!
                    }
                }
                
                if doc.type == .modified{

                    let currencyID = doc.document.data()["currencyID"] as? Int ?? 0
                    
                    let currency = doc.document.data()["currency"] as? String ?? ""
                    let money = doc.document.data()["money"] as? Int ?? 0
                    let name = doc.document.data()["name"] as? String ?? ""
                    
                    let index = self.currencies.firstIndex { (post) -> Bool in

                        return post.currencyID == currencyID

                    } ?? -1

                    if index != -1{

                        self.currencies[index].currencyID = currencyID
                        self.currencies[index].currency = currency
                        self.currencies[index].totalMoney = money
                        self.currencies[index].name = name
                        
                        if !self.currencies.isEmpty {
                            
                            self.selectedCurrency = self.currencies.first!
                        }
                    }
                }
            }
            
            withAnimation(.spring()){

                self.isLoading = false
            }
        }
    }
    
    //MARK: - COUNTRY FLAG IN TEXT
    public func countryFlag(countryCode: String) -> String {
        
      return String(String.UnicodeScalarView(
        
         countryCode.unicodeScalars.compactMap(
           {
               UnicodeScalar(127397 + $0.value)
               
           })))
    }
    
    public func countAllOperations() -> Int {
        
        var result = 0
        
        for currency in currencies {
            
            result += currency.totalMoney
        }
        
        return result
    }
}
