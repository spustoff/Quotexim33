//
//  AddView.swift
//  Quotex33
//
//  Created by Вячеслав on 12/13/22.
//

import SwiftUI

struct AddView: View {
    
    @StateObject var viewModel = AddViewModel()
    let account: MyAccountsModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                VStack {
                 
                    HStack {
                        
                        Text("Add transaction")
                            .foregroundColor(.white)
                            .font(.system(size: 21, weight: .semibold))
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.cleanFields()
                                
                                UIApplication.shared.endEditing()
                                presentationMode.wrappedValue.dismiss()
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.gray)
                                .font(.system(size: 13, weight: .regular))
                                .frame(width: 30, height: 30)
                                .background(Circle().fill(Color("card")))
                        })
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.addHistory(account: account)
                                viewModel.updateCountCurrency(account: account)
                                
                                UIApplication.shared.endEditing()
                            }
                            
                        }, label: {
                            
                            Image("add")
                                .frame(width: 30, height: 30)
                                .background(Circle().fill(Color("card")))
                        })
                        .disabled(viewModel.type.isEmpty || viewModel.category.isEmpty || viewModel.sum.isEmpty ? true : false)
                        .opacity(viewModel.type.isEmpty || viewModel.category.isEmpty || viewModel.sum.isEmpty ? 0.5 : 1)
                    }
                    
                    Divider()
                }
                .padding()
                
                ScrollView(.vertical, showsIndicators: true) {
                    
                    LazyVStack {
                        
                        VStack(alignment: .leading, content: {
                            
                            //MARK: - TYPES
                            Text("Type")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .semibold))
                            
                            LazyHStack {
                                
                                ForEach(viewModel.types, id: \.self) { index in
                                    
                                    VStack {
                                        
                                        Image(index)
                                        
                                        Text(index)
                                            .foregroundColor(.white)
                                            .font(.system(size: 14, weight: .regular))
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .background(RoundedRectangle(cornerRadius: 15).stroke(viewModel.type == index ? Color("green") : Color.gray.opacity(0.3), lineWidth: 1))
                                    .onTapGesture {
                                        
                                        withAnimation(.spring()) {
                                            
                                            viewModel.type = index
                                        }
                                    }
                                }
                            }
                            .frame(height: 130)
                            .padding(1)
                            .padding(.bottom)
                            
                            //MARK: - CATEGORIES
                            Text("Category")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .semibold))
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                
                                LazyHStack {
                                    
                                    ForEach(viewModel.categories, id: \.self) { index in
                                        
                                        VStack {
                                            
                                            Image(index.lowercased())
                                            
                                            Text(index)
                                                .foregroundColor(.white)
                                                .font(.system(size: 15, weight: .regular))
                                        }
                                        .padding()
                                        .background(RoundedRectangle(cornerRadius: 15).stroke(viewModel.category == index ? Color("green") : Color.gray.opacity(0.3), lineWidth: 1))
                                        .padding(.trailing)
                                        .padding(1)
                                        .onTapGesture {
                                            
                                            withAnimation(.spring()) {
                                                
                                                viewModel.category = index
                                            }
                                        }
                                    }
                                }
                            }
                            .frame(height: 130)
                            .padding(1)
                            .padding(.bottom)
                            
                            //MARK: - SUM
                            Text("Sum")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .semibold))
                            
                            ZStack(alignment: .leading) {
                                
                                Text("$100")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                    .opacity(viewModel.sum.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.sum)
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .regular))
                                    .keyboardType(.decimalPad)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.3)))
                        })
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    }
                    .modifier(AdaptsKeyboard())
                }
                
                Spacer()
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .padding(.top, 30)
        }
    }
}
