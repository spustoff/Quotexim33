//
//  BaseCurrencyView.swift
//  Quotex33
//
//  Created by Вячеслав on 12/11/22.
//

import SwiftUI

struct BaseCurrencyView: View {
    
    @AppStorage("selectedCurrency") var selectedCurrency: String = "USD"
    @StateObject var viewModel = BaseCurrencyViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Image("basecurrency")
                
                Text("Select the base currency")
                    .foregroundColor(.white)
                    .font(.system(size: 25, weight: .semibold))
                
                Text("Your total balance will be counted\nin this curency")
                    .foregroundColor(.gray)
                    .font(.system(size: 16, weight: .regular))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Button(action: {
                    
                    withAnimation(.spring()) {
                        
                        let impactLight = UIImpactFeedbackGenerator(style: .light)
                        impactLight.impactOccurred()
                        
                        viewModel.showList = true
                    }
                    
                }, label: {
                    
                    HStack {
                        
                        Text(viewModel.countryFlag(countryCode: String(selectedCurrency.dropLast())))
                            .font(.system(size: 20))
                        
                        Text(selectedCurrency)
                            .foregroundColor(.white)
                            .font(.system(size: 19, weight: .semibold))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .foregroundColor(Color("green"))
                            .font(.system(size: 15, weight: .regular))
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 35)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color("card")))
                    .padding()
                })
                
                Spacer()
                
                NavigationLink(destination: {
                    
                    RateView()
                        .navigationBarBackButtonHidden()
                    
                }, label: {
                    
                    Text("Start")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .regular))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color("green")))
                        .padding()
                })
                .disabled(selectedCurrency.isEmpty ? true : false)
                .opacity(selectedCurrency.isEmpty ? 0.5 : 1)
            }
        }
        .sheet(isPresented: $viewModel.showList, content: {
            
            BaseCurrencyListView(viewModel: viewModel)
        })
    }
}

struct BaseCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        BaseCurrencyView()
    }
}
