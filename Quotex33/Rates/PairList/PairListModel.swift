//
//  PairListModel.swift
//  Quotex33
//
//  Created by Вячеслав on 12/12/22.
//

import SwiftUI

struct PairListModel: Identifiable, Hashable, Codable {
    
    var id: UUID? = UUID()
    
    var error: Bool
    var messages: [String]
    
    var currencies: [PairModel]
}

struct PairModel: Identifiable, Hashable, Codable {
    
    var id: UUID? = UUID()
    
    var pair: String
    var price: Double
    var isTrendUp: Bool
    
    var changeInPercent: Double
    var change: Double
    var bid: Double
    var ask: Double
    var max: Double
    var min: Double
    var currencyAt: String
}
