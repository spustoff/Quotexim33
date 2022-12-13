//
//  MyAccountsView.swift
//  Quotex33
//
//  Created by Вячеслав on 12/12/22.
//

import SwiftUI

struct MyAccountsView: View {
    
    @AppStorage("selectedCurrency") var selectedCurrency: String = ""
    @StateObject var viewModel = MyAccountsViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            LinearGradient(colors: [Color("greenbg"), Color.white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        
                        Text("Balance")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .regular))
                        
                        Spacer()
                        
                        Menu {
                            
                            ForEach(viewModel.currencies, id: \.self) { index in
                                
                                Button(action: {
                                    
                                    withAnimation(.spring()) {
                                        
                                        selectedCurrency = index
                                    }
                                    
                                }, label: {
                                    
                                    HStack {
                                        
                                        Text(index)
                                            
                                        Spacer()
                                        
                                        if selectedCurrency == index {
                                            
                                            Image(systemName: "xmark")
                                        }
                                    }
                                })
                            }
                            
                        } label: {
                            
                            HStack {
                                
                                Text(selectedCurrency)
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .regular))
                                
                                Image(systemName: "chevron.down")
                                    .foregroundColor(Color("green"))
                                    .font(.system(size: 14, weight: .regular))
                            }
                        }
                    }
                    
                    Text("$0")
                        .foregroundColor(.white)
                        .font(.system(size: 31, weight: .semibold))
                    
                    NavigationLink(destination: {}, label: {
                        
                        Text("View general statistics")
                            .foregroundColor(Color("green"))
                            .font(.system(size: 15, weight: .regular))
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color("green"))
                            .font(.system(size: 14, weight: .regular))
                    })
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 15).fill(Color("card").opacity(0.2)))
                .padding(.horizontal)
                
                HStack {
                    
                    VStack(alignment: .leading, content: {
                        
                        Text("Operations for all time")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                        
                        HStack {
                            
                            Text("$0")
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .semibold))
                            
                            Image(systemName: "chevron.up")
                                .foregroundColor(Color("green"))
                                .font(.system(size: 15, weight: .regular))
                        }
                    })
                    
                    Spacer()
                    
                    VStack(alignment: .leading, content: {
                        
                        Text("Operations for today")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                        
                        HStack {
                            
                            Text("$0")
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .semibold))
                            
                            Image(systemName: "chevron.down")
                                .foregroundColor(Color.red)
                                .font(.system(size: 15, weight: .regular))
                        }
                    })
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 15).fill(Color("card").opacity(0.2)))
                .padding(.horizontal)
                
                Spacer()
                
            }
        }
        .overlay(
        
            VStack {
                
                Spacer()
                
                ZStack(alignment: .bottom, content: {
                    
                    VStack {
                        
                        HStack {
                            
                            Text("My Accounts")
                                .foregroundColor(.white)
                                .font(.system(size: 19, weight: .semibold))
                            
                            Spacer()
                            
                            Button(action: {
                                
                                withAnimation(.spring()) {
                                    
                                    viewModel.showNewAccount = true
                                }
                                
                            }, label: {
                                
                                Image("add")
                            })
                        }
                        
                        Spacer()
                        
                        VStack {
                            
                            Image("emptyaccounts")
                            
                            Text("The accounts are empty")
                                .foregroundColor(.gray)
                                .font(.system(size: 25, weight: .semibold))
                            
                            Text("Click the 'add' button at the top to create a new account")
                                .foregroundColor(.gray)
                                .font(.system(size: 18, weight: .regular))
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxHeight: .infinity, alignment: .center)
                    }
                    .padding(30)
                })
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.5)
                .background(RoundedRectangle(cornerRadius: 25).fill(Color("bg")))
            }
        )
        .ignoresSafeArea(.all, edges: .bottom)
        .sheet(isPresented: $viewModel.showNewAccount, content: {
            
            NewAccountView()
        })
    }
}

struct MyAccountsView_Previews: PreviewProvider {
    static var previews: some View {
        MyAccountsView()
    }
}
