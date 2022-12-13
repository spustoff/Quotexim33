//
//  RateView.swift
//  Quotex33
//
//  Created by Вячеслав on 12/12/22.
//

import SwiftUI
import StoreKit

struct RateView: View {
    
    @StateObject var viewModel = RateViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Image("rate")
                    .padding(.top, 150)
                    
                Text("Rate our app in the\nAppstore")
                    .foregroundColor(.white)
                    .font(.system(size: 26, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .padding(.top)
                
                Text("This helps to make it even better")
                    .foregroundColor(.gray)
                    .font(.system(size: 15, weight: .regular))
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Button(action: {
                    
                    withAnimation(.spring()) {
                        
                        let impactLight = UIImpactFeedbackGenerator(style: .light)
                        impactLight.impactOccurred()
                        
                        viewModel.createAccount()
                    }
                    
                }, label: {
                    
                    ZStack {
                        
                        if viewModel.isLoading {
                            
                            ProgressView()
                            
                        } else {
                            
                            Text("Rate")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .regular))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color("green")))
                    .padding()
                })
            }
            .onAppear{
                
                SKStoreReviewController.requestReview()
            }
        }
    }
}

struct RateView_Previews: PreviewProvider {
    static var previews: some View {
        RateView()
    }
}
