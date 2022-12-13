//
//  DetailAccountModel.swift
//  Quotex33
//
//  Created by Вячеслав on 12/13/22.
//

import SwiftUI
import Firebase

struct HistoryModel: Identifiable {
    
    var id = UUID().uuidString
    
    var type: String
    var currency: String
    var category: String
    var sum: Int
    var createdDate: Timestamp
}
