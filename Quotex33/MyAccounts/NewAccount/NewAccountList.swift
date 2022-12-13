//
//  NewAccountList.swift
//  Quotex33
//
//  Created by Вячеслав on 12/12/22.
//

import SwiftUI

struct NewAccountList: View {
    
    @StateObject var viewModel: NewAccountViewModel
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
                            
                            Button(action: {
                                
                                withAnimation(.spring()) {
                                    
                                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                                    impactLight.impactOccurred()
                                    
                                    viewModel.currencyField  = index
                                    
                                    presentationMode.wrappedValue.dismiss()
                                    viewModel.showListCurrency = false
                                }
                                
                            }, label: {
                                
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
                                                .opacity(viewModel.currencyField == index ? 1 : 0)
                                        
                                        )
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color("card")))
                                .padding(.horizontal)
                            })
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
