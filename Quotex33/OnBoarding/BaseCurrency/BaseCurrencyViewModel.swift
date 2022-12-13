//
//  BaseCurrencyViewModel.swift
//  Quotex33
//
//  Created by Вячеслав on 12/11/22.
//

import SwiftUI

final class BaseCurrencyViewModel: ObservableObject {
    
    @Published var currencies: [String] = ["EUR", "USD", "RUB", "TRY", "KZT", "UAH", "BYN", "GBP"]
    @Published var search = ""
    @Published var showList = false
    
    //MARK: - COUNTRY FLAG IN TEXT
    public func countryFlag(countryCode: String) -> String {
        
      return String(String.UnicodeScalarView(
        
         countryCode.unicodeScalars.compactMap(
           {
               UnicodeScalar(127397 + $0.value)
               
           })))
    }
}
