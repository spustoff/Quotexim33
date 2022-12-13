//
//  MyAccountsModel.swift
//  Quotex33
//
//  Created by Вячеслав on 12/12/22.
//

import SwiftUI

struct MyAccountsModel: Identifiable {
    
    var id = UUID().uuidString
    
    var currencyID: Int
    var currency: String
    var totalMoney: Int
    var name: String
}
