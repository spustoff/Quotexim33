//
//  RateViewModel.swift
//  Quotex33
//
//  Created by Вячеслав on 12/12/22.
//

import SwiftUI
import Firebase

final class RateViewModel: ObservableObject {
    
    @Published var deviceID = UIDevice.current.identifierForVendor!.uuidString
    @AppStorage("status") var status: Bool = false
    @Published var isLoading: Bool = false
    
    let ref = Firestore.firestore()
    
    public func createAccount() {
        
        isLoading = true
        
        self.ref.collection("Devices").document("\(deviceID)").setData([
        
            "deviceID": deviceID,
        
        ]) { (err) in

            if err != nil{

                self.isLoading = false
                
                return
            }
        
            withAnimation(.spring()) {
                
                self.status = true
                self.isLoading = false
            }
        }
    }
}
