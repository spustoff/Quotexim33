//
//  MyAccountsViewModel.swift
//  Quotex33
//
//  Created by Вячеслав on 12/12/22.
//

import SwiftUI

final class MyAccountsViewModel: ObservableObject {
    
    @Published var currencies: [String] = ["EUR", "USD", "RUB", "TRY", "KZT", "UAH", "BYN", "GBP"]
    @Published var showNewAccount: Bool = false
}
