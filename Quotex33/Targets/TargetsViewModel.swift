//
//  TargetsViewModel.swift
//  Quotex33
//
//  Created by Вячеслав on 12/12/22.
//

import SwiftUI
import Firebase

final class TargetsViewModel: ObservableObject {
    
    @Published var showNewTarget: Bool = false
    @Published var showAddDeposit = false
    
    @Published var isLoading = false
    
    //MARK: TARGETS
    @Published var targets: [TargetModel] = []
    
    //MARK: ADD DEPOSIT
    @Published var depositCount = ""
    @Published var selectedTarget: TargetModel?
    
    let ref = Firestore.firestore()
    
    @Published var deviceID = UIDevice.current.identifierForVendor!.uuidString

    init() {
        
        getTargets()
    }
    
    public func getTargets(){
        
        withAnimation(.spring()){

            self.isLoading = true
        }

        self.ref.collection("Devices").document("\(deviceID)").collection("Targets").addSnapshotListener { (QuerySnapshot, error) in

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
                    
                    let targetID = doc.document.data()["targetID"] as? Int ?? 0
                    
                    let title = doc.document.data()["name"] as? String ?? ""
                    let totalCount = doc.document.data()["totalCount"] as? Int ?? 0
                    let currentCount = doc.document.data()["currentCount"] as? Int ?? 0
                    
                    self.targets.append(TargetModel(title: title, targetID: targetID, totalCount: totalCount, currentCount: currentCount))
                }
                
                if doc.type == .removed{

                    let targetID = doc.document.data()["targetID"] as? Int ?? 0

                    self.targets.removeAll { (post) -> Bool in

                        return post.targetID == targetID
                    }
                }
                
                if doc.type == .modified{

                    let targetID = doc.document.data()["targetID"] as? Int ?? 0
                    
                    let title = doc.document.data()["name"] as? String ?? ""
                    let totalCount = doc.document.data()["totalCount"] as? Int ?? 0
                    let currentCount = doc.document.data()["currentCount"] as? Int ?? 0
                    
                    let index = self.targets.firstIndex { (post) -> Bool in

                        return post.targetID == targetID

                    } ?? -1

                    if index != -1{

                        self.targets[index].targetID = targetID
                        self.targets[index].title = title
                        self.targets[index].totalCount = totalCount
                        self.targets[index].currentCount = currentCount
                    }
                }
            }
            
            withAnimation(.spring()){

                self.isLoading = false
            }
        }
    }
    
    public func removeFromTargets(name: String) {
        
        withAnimation(.spring()){
            
            isLoading = true
        }
        
        self.ref.collection("Devices").document("\(deviceID)").collection("Targets").document(name).delete() { (err) in

            if err != nil{

                withAnimation(.spring()){
                    
                    self.isLoading = false
                }
                
                return
            }
            
            self.isLoading = false
        }
    }
    
    public func addDeposit(){
        
        withAnimation(.spring()){
            
            isLoading = true
        }
        
        self.ref.collection("Devices").document("\(deviceID)").collection("Targets").document(selectedTarget?.title ?? "").updateData([

            "currentCount": (selectedTarget?.currentCount ?? 0) + (Int(depositCount) ?? 0),
        
        ]) { (err) in

            if err != nil{

                withAnimation(.spring()){
                    
                    self.isLoading = false
                }
                
                return
            }
            
            self.depositCount = ""
            self.showAddDeposit = false
            self.isLoading = false
            
            if (self.selectedTarget?.currentCount ?? 0) > (self.selectedTarget?.totalCount ?? 0) {
                
                self.removeFromTargets(name: self.selectedTarget?.title ?? "")
            }
        }
    }
}
