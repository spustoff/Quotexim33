//
//  NewAccountViewModel.swift
//  Quotex33
//
//  Created by Вячеслав on 12/12/22.
//

import SwiftUI
import Firebase

final class NewAccountViewModel: ObservableObject {
    
    @Published var nameField: String = ""
    @Published var currencyField: String = "USD"
    
    @Published var showListCurrency: Bool = false
    
    @Published var currencies: [String] = ["EUR", "USD", "RUB", "TRY", "KZT", "UAH", "BYN", "GBP"]
    @Published var search = ""
    
    @Published var isLoading = false
    
    let ref = Firestore.firestore()
    
    @Published var deviceID = UIDevice.current.identifierForVendor!.uuidString
    
    public func addCurrency(){
        
        let randomID = Int.random(in: 1...99999)
        
        isLoading = true
        
        self.ref.collection("Devices").document("\(deviceID)").collection("Currencies").document(nameField).setData([
        
            "currencyID": randomID,
            "currency": currencyField,
            "money": 0,
            "name": nameField,
        
        ]) { (err) in

            if err != nil{

                self.isLoading = false
                
                return
            }
        }
        
        self.isLoading = false
        self.nameField = ""
        
        let impactLight = UIImpactFeedbackGenerator(style: .light)
        impactLight.impactOccurred()
    }
    
    //MARK: - COUNTRY FLAG IN TEXT
    public func countryFlag(countryCode: String) -> String {
        
      return String(String.UnicodeScalarView(
        
         countryCode.unicodeScalars.compactMap(
           {
               UnicodeScalar(127397 + $0.value)
               
           })))
    }
}
