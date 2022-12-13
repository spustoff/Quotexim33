//
//  BaseCurrencyListView.swift
//  Quotex33
//
//  Created by Вячеслав on 12/11/22.
//

import SwiftUI

struct BaseCurrencyListView: View {
    
    @StateObject var viewModel: BaseCurrencyViewModel
    @AppStorage("selectedCurrency") var selectedCurrency: String = "USD"
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Currency")
                    .foregroundColor(.white)
                    .font(.system(size: 19, weight: .semibold))
                
                HStack {
                    
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .font(.system(size: 14, weight: .regular))
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Search")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.search.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.search)
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                    })
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 15).fill(Color("card").opacity(0.4)))
                .padding()
                
                ScrollView(.vertical, showsIndicators: true) {
                    
                    LazyVStack {
                        
                        ForEach(viewModel.search.isEmpty ? viewModel.currencies : viewModel.currencies.filter{$0.lowercased().contains(viewModel.search.lowercased())}, id: \.self) { index in
                            
                            HStack{
                                
                                Text(viewModel.countryFlag(countryCode: String(index.dropLast())))
                                    .font(.system(size: 20))
                                
                                Text(index)
                                    .foregroundColor(.white)
                                    .font(.system(size: 17, weight: .semibold))
                                
                                Spacer()
                                
                                Circle()
                                    .stroke(Color.gray, lineWidth: 1)
                                    .frame(width: 25, height: 25)
                                    .overlay(
                                    
                                        Circle()
                                            .fill(Color("green"))
                                            .frame(width: 20, height: 20)
                                            .opacity(selectedCurrency == index ? 1 : 0)
                                    
                                    )
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("card")))
                            .padding(.horizontal)
                            .onTapGesture {
                                
                                withAnimation(.spring()) {
                                    
                                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                                    impactLight.impactOccurred()
                                    
                                    selectedCurrency = index
                                    
                                    presentationMode.wrappedValue.dismiss()
                                    viewModel.showList = false
                                }
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.top, 40)
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}
