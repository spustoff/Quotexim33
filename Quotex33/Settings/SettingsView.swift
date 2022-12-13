//
//  SettingsView.swift
//  Quotex33
//
//  Created by Вячеслав on 12/12/22.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                VStack {
                 
                    Text("Settings")
                        .foregroundColor(.white)
                        .font(.system(size: 21, weight: .semibold))
                    
                    Divider()
                }
                .padding()
                
                Button(action: {
                    
                    SKStoreReviewController.requestReview()
                    
                }, label: {
                    
                    HStack {
                        
                        Image("ratebutton")
                        
                        Text("Rate our app")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .regular))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color("green"))
                            .font(.system(size: 15, weight: .regular))
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color("card").opacity(0.2)))
                    .padding(.horizontal)
                })
                
                Button(action: {
                    
                    EmailHelper.shared.send(subject: "Support", body: "", to: ["quotex2568@gmail.com"])
                    
                }, label: {
                    
                    HStack {
                        
                        Image("supportbutton")
                        
                        Text("Support")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .regular))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color("green"))
                            .font(.system(size: 15, weight: .regular))
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color("card").opacity(0.2)))
                    .padding(.horizontal)
                })
                
                Spacer()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
