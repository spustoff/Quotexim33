//
//  RatesViewModel.swift
//  Quotex33
//
//  Created by Вячеслав on 12/12/22.
//

import SwiftUI

final class RatesViewModel: ObservableObject {
    
    @Published var intervals: [String] = ["30", "40", "50", "60", "90"]
    @Published var selectedInterval: String = "90"
    @Published var selectedPair: String = "EURUSD"
    
    @Published var isLoading = false
    @Published var list: Bool = false
    @Published var search: String = ""
    @Published var pairs: [PairListModel] = []
    
    func loadData() -> Void {
        
        isLoading = true
        
        let url = URL(string: "https://qtb.binaariums.site")!
        var request = URLRequest(url: url)
        
        request.setValue(
            "authToken",
            forHTTPHeaderField: "Authorization"
        )
        
        request.setValue(
            
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "apsituantig.site"
        components.path = "/api/currencies/current"

        components.queryItems = [
            
            URLQueryItem(name: "token", value: "4adtckJzpCSWqDDK6JmbMMi4fWEzt0LTF7E")
        ]
        
//        print(components.string! as String)
        
        guard let urlString = URL(string: components.string!) else {
            
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlString){ data, _, error in
            
            guard let data = data, error == nil else {
                
                return
            }
            
            do{
                
                let currencies = try JSONDecoder().decode(PairListModel.self, from: data)
                
                DispatchQueue.main.async {
                    
                    self.isLoading = false
                    self.pairs.append(currencies)
                }
                
            } catch{
                
                self.isLoading = false
                
                print(error)
            }
        }
        
        task.resume()
    }
    
    //MARK: - COUNTRY FLAG IN TEXT
    public func countryFlag(countryCode: String) -> String {
        
      return String(String.UnicodeScalarView(
        
         countryCode.unicodeScalars.compactMap(
           {
               UnicodeScalar(127397 + $0.value)
               
           })))
    }
}
