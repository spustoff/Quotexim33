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
                            
                            ForEach(viewModel.currencies) { index in
                                
                                Button(action: {
                                    
                                    withAnimation(.spring()) {
                                        
                                        viewModel.selectedCurrency = index
                                    }
                                    
                                }, label: {
                                    
                                    HStack {
                                        
                                        Text(index.currency)
                                            
                                        Spacer()
                                        
                                        if viewModel.selectedCurrency.currency == index.currency {
                                            
                                            Image(systemName: "xmark")
                                        }
                                    }
                                })
                            }
                            
                        } label: {
                            
                            HStack {
                                
                                Text(viewModel.selectedCurrency.currency)
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .regular))
                                
                                Image(systemName: "chevron.down")
                                    .foregroundColor(Color("green"))
                                    .font(.system(size: 14, weight: .regular))
                            }
                        }
                    }
                    
                    Text("$\(viewModel.selectedCurrency.totalMoney)")
                        .foregroundColor(.white)
                        .font(.system(size: 31, weight: .semibold))
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
                            
                            Text("$\(viewModel.countAllOperations())")
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
                            
                            Text("$\(viewModel.countAllOperations())")
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
                        .padding(.horizontal, 17)
                        
                        Spacer()
                        
                        if viewModel.currencies.isEmpty {
                            
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
                            
                        } else {
                            
                            ScrollView(.vertical, showsIndicators: true) {
                                
                                LazyVStack {
                                    
                                    ForEach(viewModel.currencies) { index in
                                        
                                        VStack(alignment: .leading, content: {
                                            
                                            HStack {
                                                
                                                Text(index.name)
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 16, weight: .regular))
                                                
                                                Spacer()
                                                
                                                Text(index.currency)
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 14, weight: .regular))
                                                
                                                Image(systemName: "chevron.down")
                                                    .foregroundColor(Color("green"))
                                                    .font(.system(size: 14))
                                            }
                                            
                                            Text("$\(index.totalMoney)")
                                                .foregroundColor(.white)
                                                .font(.system(size: 19, weight: .semibold))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(.vertical, 3)
                                            
                                            HStack {
                                                
                                                NavigationLink(destination: {
                                                    
                                                    DetailAccountView(selectedAccount: index)
                                                        .navigationBarBackButtonHidden()
                                                    
                                                }, label: {
                                                    
                                                    HStack {
                                                        
                                                        Text("View history")
                                                            .foregroundColor(Color("green"))
                                                            .font(.system(size: 14, weight: .regular))
                                                        
                                                        Image(systemName: "chevron.right")
                                                            .foregroundColor(Color("green"))
                                                            .font(.system(size: 14, weight: .regular))
                                                    }
                                                })
                                                
                                                Spacer()
                                                
                                                Button(action: {
                                                    
                                                    withAnimation(.spring()) {
                                                        
                                                        viewModel.selectedAccount = index
                                                        
                                                        if !(viewModel.selectedAccount?.currency ?? "").isEmpty {
                                                            
                                                            viewModel.showAdding = true
                                                        }
                                                    }
                                                    
                                                }, label: {
                                                    
                                                    Image(systemName: "plus")
                                                        .foregroundColor(Color("green"))
                                                        .font(.system(size: 15, weight: .regular))
                                                })
                                            }
                                        })
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("card").opacity(0.2)))
                                    }
                                }
                                .padding(.top)
                                .padding(.horizontal, 17)
                            }
                            .padding(.bottom, 75)
                        }
                    }
                    .padding(.vertical, 17)
                    .padding(.top, 15)
                })
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.45)
                .background(RoundedRectangle(cornerRadius: 25).fill(Color("bg")))
            }
        )
        .ignoresSafeArea(.all, edges: .bottom)
        .sheet(isPresented: $viewModel.showNewAccount, content: {
            
            NewAccountView()
        })
        .sheet(isPresented: $viewModel.showAdding, content: {
            
            AddView(account: viewModel.selectedAccount!)
        })
    }
}

struct MyAccountsView_Previews: PreviewProvider {
    static var previews: some View {
        MyAccountsView()
    }
}
