//
//  NewTargetViewModel.swift
//  Quotex33
//
//  Created by Вячеслав on 12/12/22.
//

import SwiftUI
import Firebase

final class NewTargetViewModel: ObservableObject {
    
    //MARK: SHOW WINDOWS
    @Published var showNewTarget = false
    
    @Published var nameField: String = ""
    @Published var sumField: String = ""
    
    @Published var isLoading = false
    
    let ref = Firestore.firestore()
    @Published var deviceID = UIDevice.current.identifierForVendor!.uuidString
    
    public func addTarget(){
        
        withAnimation(.spring()){
            
            isLoading = true
        }
        
        let randomID = Int.random(in: 1...99999)
        
        self.ref.collection("Devices").document("\(deviceID)").collection("Targets").document(nameField).setData([
        
            "targetID": randomID,
            "name": nameField,
            "currentCount": 0,
            "totalCount": Int(sumField) ?? 0,
        
        ]) { (err) in

            if err != nil{

                withAnimation(.spring()){
                    
                    self.isLoading = false
                }
                
                return
            }
            
            self.nameField = ""
            self.sumField = ""
            self.showNewTarget = false
            
            self.isLoading = false
        }
    }
}
