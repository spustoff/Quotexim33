//
//  NewAccountViewModel.swift
//  Quotex33
//
//  Created by Вячеслав on 12/12/22.
//

import SwiftUI

final class NewAccountViewModel: ObservableObject {
    
    @Published var nameField: String = ""
    @Published var currencyField: String = "USD"
    
    @Published var showListCurrency: Bool = false
    
    @Published var currencies: [String] = ["EUR", "USD", "RUB", "TRY", "KZT", "UAH", "BYN", "GBP"]
    @Published var search = ""
    
    //MARK: - COUNTRY FLAG IN TEXT
    public func countryFlag(countryCode: String) -> String {
        
      return String(String.UnicodeScalarView(
        
         countryCode.unicodeScalars.compactMap(
           {
               UnicodeScalar(127397 + $0.value)
               
           })))
    }
}
