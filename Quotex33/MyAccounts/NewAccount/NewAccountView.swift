//
//  NewAccountView.swift
//  Quotex33
//
//  Created by Вячеслав on 12/12/22.
//

import SwiftUI

struct NewAccountView: View {
    
    @StateObject var viewModel = NewAccountViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("New account")
                        .foregroundColor(.white)
                        .font(.system(size: 19, weight: .semibold))
                    
                    Button(action: {}, label: {
                        
                        Text("Done")
                            .foregroundColor(Color("green"))
                            .font(.system(size: 15, weight: .regular))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    })
                    .disabled(viewModel.nameField.isEmpty || viewModel.currencyField.isEmpty ? true : false)
                    .opacity(viewModel.nameField.isEmpty || viewModel.currencyField.isEmpty ? 0.5 : 1)
                }
                .padding()
                
                ZStack(alignment: .leading) {
                    
                    Text("Name")
                        .foregroundColor(.gray)
                        .font(.system(size: 14, weight: .regular))
                        .opacity(viewModel.nameField.isEmpty ? 1 : 0)
                    
                    TextField("", text: $viewModel.nameField)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .regular))
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 11).stroke(viewModel.nameField.isEmpty ? Color.gray.opacity(0.5) : Color("green"), lineWidth: 1))
                .padding(.horizontal)
                
                Button(action: {
                    
                    withAnimation(.spring()) {
                        
                        viewModel.showListCurrency = true
                    }
                    
                }, label: {
                    
                    HStack {
                        
                        Text(viewModel.countryFlag(countryCode: String(viewModel.currencyField.dropLast())))
                            .font(.system(size: 25))
                        
                        Text(viewModel.currencyField)
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .semibold))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .foregroundColor(Color("green"))
                            .font(.system(size: 14, weight: .regular))
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 11).stroke(viewModel.currencyField.isEmpty ? Color.gray.opacity(0.5) : Color("green"), lineWidth: 1))
                    .padding(.horizontal)
                    .padding(.top)
                })
                
                Spacer()
            }
        }
        .sheet(isPresented: $viewModel.showListCurrency, content: {
            
            NewAccountList(viewModel: viewModel)
        })
    }
}

struct NewAccountView_Previews: PreviewProvider {
    static var previews: some View {
        NewAccountView()
    }
}
