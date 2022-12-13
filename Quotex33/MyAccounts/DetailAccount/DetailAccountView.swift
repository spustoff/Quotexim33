//
//  DetailAccountView.swift
//  Quotex33
//
//  Created by Вячеслав on 12/13/22.
//

import SwiftUI

struct DetailAccountView: View {
    
    @StateObject var viewModel = DetailAccountViewModel()
    let selectedAccount: MyAccountsModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                VStack {
                 
                    ZStack {
                        
                        Text(selectedAccount.name)
                            .foregroundColor(.white)
                            .font(.system(size: 21, weight: .semibold))
                        
                        HStack {
                            
                            Button(action: {
                                
                                withAnimation(.spring()) {
                                    
                                    presentationMode.wrappedValue.dismiss()
                                }
                                
                            }, label: {
                                
                                Image(systemName: "chevron.left")
                                    .foregroundColor(Color("green"))
                                    .font(.system(size: 19, weight: .semibold))
                            })
                            
                            Spacer()
                            
                            Button(action: {
                                
                                withAnimation(.spring()) {
                                    
                                    viewModel.removeCurrency(account: selectedAccount)
                                    presentationMode.wrappedValue.dismiss()
                                }
                                
                            }, label: {
                                
                                Image("delete")
                            })
                        }
                    }
                    
                    Divider()
                }
                .padding()
                
                if viewModel.history.isEmpty {
                    
                    VStack {
                        
                        Image("emptyaccounts")
                        
                        Text("The history are empty")
                            .foregroundColor(.gray)
                            .font(.system(size: 25, weight: .semibold))
                        
                        Text("Create first history item")
                            .foregroundColor(.gray)
                            .font(.system(size: 18, weight: .regular))
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxHeight: .infinity, alignment: .center)
                    
                } else {
                    
                    if viewModel.isLoading {
                        
                        ProgressView()
                        
                    } else {
                        
                        ScrollView(.vertical, showsIndicators: true) {
                            
                            LazyVStack {
                                
                                ForEach(viewModel.history) { index in
                                    
                                    HStack {
                                        
                                        VStack(alignment: .leading, content: {
                                            
                                            Text(index.category)
                                                .foregroundColor(.white)
                                                .font(.system(size: 16, weight: .regular))
                                            
                                            Text(viewModel.formatTransactionTimpestamp(timestamp: index.createdDate, isTime: true))
                                                .foregroundColor(.gray)
                                                .font(.system(size: 14, weight: .regular))
                                        })
                                        
                                        Spacer()
                                        
                                        if index.type == "Income" {
                                            
                                            Text("+\(index.sum)")
                                                .foregroundColor(.green)
                                                .font(.system(size: 15, weight: .regular))
                                        } else {
                                            
                                            Text("-\(index.sum)")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 15, weight: .regular))
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 45)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 15).fill(Color.gray.opacity(0.1)))
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                }
                
                Spacer()
            }
        }
        .onAppear {
            
            viewModel.getHistory(selectedCurrency: selectedAccount)
        }
    }
}
