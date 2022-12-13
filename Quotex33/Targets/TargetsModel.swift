//
//  TargetsModel.swift
//  Quotex33
//
//  Created by Вячеслав on 12/12/22.
//

import SwiftUI

struct TargetModel: Identifiable {
    
    var id = UUID().uuidString
    
    var title: String
    var targetID: Int
    
    var totalCount: Int
    var currentCount: Int
}

