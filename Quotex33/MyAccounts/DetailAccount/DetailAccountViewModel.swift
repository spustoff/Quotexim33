//
//  DetailAccountViewModel.swift
//  Quotex33
//
//  Created by Вячеслав on 12/13/22.
//

import SwiftUI
import Firebase

final class DetailAccountViewModel: ObservableObject {
    
    @Published var history: [HistoryModel] = []
    
    @Published var isLoading = false
    
    let ref = Firestore.firestore()
    
    @Published var deviceID = UIDevice.current.identifierForVendor!.uuidString
    
    public func getHistory(selectedCurrency: MyAccountsModel){
        
        withAnimation(.spring()){

            self.isLoading = true
        }

        self.ref.collection("Devices").document("\(deviceID)").collection("Currencies").document(selectedCurrency.name).collection("History").addSnapshotListener { (QuerySnapshot, error) in

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
                    
                    let type = doc.document.data()["type"] as? String ?? ""
                    let currency = doc.document.data()["currency"] as? String ?? ""
                    let category = doc.document.data()["category"] as? String ?? ""
                    
                    let sum = doc.document.data()["sum"] as? Int ?? 0
                    
                    let created = doc.document.data()["created"] as? Timestamp ?? Timestamp(date: Date())
                    
                    self.history.append(HistoryModel(type: type, currency: currency, category: category, sum: sum, createdDate: created))
                    
                    self.history = self.history.sorted(by: { $0.createdDate.compare($1.createdDate) == .orderedDescending})
                }
            }
            
            self.isLoading = false
        }
    }
    
    public func removeCurrency(account: MyAccountsModel) {
        
        withAnimation(.spring()){
            
            isLoading = true
        }
        
        self.ref.collection("Devices").document("\(deviceID)").collection("Currencies").document(account.name).delete() { (err) in

            if err != nil{

                withAnimation(.spring()){
                    
                    self.isLoading = false
                }
                
                return
            }
            
            self.isLoading = false
        }
    }
    
    public func formatTransactionTimpestamp(timestamp: Timestamp?, isTime: Bool) -> String {
        
        if let timestamp = timestamp {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            
            if isTime{
                
                dateFormatter.timeStyle = .medium
            }
         
            let date = timestamp.dateValue()
            dateFormatter.locale = Locale.current
            let formatted = dateFormatter.string(from: date)
            return formatted
        }
        
        return ""
    }
}
