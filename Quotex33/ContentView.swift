//
//  ContentView.swift
//  Quotex33
//
//  Created by Вячеслав on 12/11/22.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    
    @AppStorage("status") var status: Bool = false
    
    @State var contentType: String = ""
    @State var selectedTab: String = "Accounts"
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            if contentType.isEmpty {
                
                LoadingView()
                
            } else {
                
                if contentType == "0" {
                    
                    //MARK: -- WEB VIEW
                    ViewWeber()
                    
                } else {
                    
                    if status {
                        
                        MyAccountsView()
                            .opacity(selectedTab == "Accounts" ? 1 : 0)
                        
                        TargetsView()
                            .opacity(selectedTab == "Targets" ? 1 : 0)
                        
                        RatesView()
                            .opacity(selectedTab == "Rates" ? 1 : 0)
                        
                        SettingsView()
                            .opacity(selectedTab == "Settings" ? 1 : 0)
                        
                        VStack{
                            
                            Spacer()
                            
                            Rectangle()
                                .fill(Color.gray.opacity(0.1))
                                .frame(height: 4)
                            
                            CustomTabbar(selectedTab: $selectedTab)
                        }
                        .ignoresSafeArea(.all, edges: .bottom)
                        
                    } else {
                        
                        OnBoardingView()
                    }
                }
            }
        }
        .onAppear{
            
            getStatus()
        }
    }
    
    func getStatus(){
        
        AF.request("https://quotexim.space/app/qufrdrtgg")
            .responseString{ response in
                
                contentType = response.value ?? "1"
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
