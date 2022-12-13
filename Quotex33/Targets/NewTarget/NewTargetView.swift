//
//  NewTargetView.swift
//  Quotex33
//
//  Created by Вячеслав on 12/12/22.
//

import SwiftUI

struct NewTargetView: View {
    
    @StateObject var viewModel = NewTargetViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("New target")
                        .foregroundColor(.white)
                        .font(.system(size: 19, weight: .semibold))
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.addTarget()
                            
                            UIApplication.shared.endEditing()
                        }
                        
                    }, label: {
                        
                        ZStack {
                            
                            if viewModel.isLoading {
                                
                                ProgressView()
                                
                            } else {
                                
                                Text("Done")
                                    .foregroundColor(Color("green"))
                                    .font(.system(size: 15, weight: .regular))
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    })
                    .disabled(viewModel.nameField.isEmpty || viewModel.sumField.isEmpty ? true : false)
                    .opacity(viewModel.nameField.isEmpty || viewModel.sumField.isEmpty ? 0.5 : 1)
                }
                .padding()
                
                Divider()
                
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
                .padding(.top)
                
                ZStack(alignment: .leading) {
                    
                    Text("$100")
                        .foregroundColor(.gray)
                        .font(.system(size: 14, weight: .regular))
                        .opacity(viewModel.sumField.isEmpty ? 1 : 0)
                    
                    TextField("", text: $viewModel.sumField)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .regular))
                        .keyboardType(.decimalPad)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 11).stroke(viewModel.sumField.isEmpty ? Color.gray.opacity(0.5) : Color("green"), lineWidth: 1))
                .padding(.horizontal)
                .padding(.top)
                
                Spacer()
            }
            .padding(.top)
        }
    }
}

struct NewTargetView_Previews: PreviewProvider {
    static var previews: some View {
        NewTargetView()
    }
}
