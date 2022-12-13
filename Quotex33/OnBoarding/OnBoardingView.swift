//
//  OnBoardingView.swift
//  Quotex33
//
//  Created by Вячеслав on 12/11/22.
//

import SwiftUI

struct OnBoardingView: View {
    
    @StateObject var viewModel = OnBoardingViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                TabView(selection: $viewModel.selection, content: {
                    
                    ForEach(viewModel.rows) { index in
                        
                        VStack {
                            
                            Image(index.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 400)
                                .padding(.bottom, 20)
                            
                            Text(index.title)
                                .foregroundColor(.white)
                                .font(.system(size: 23, weight: .semibold))
                                .multilineTextAlignment(.center)
                            
                            Text(index.subtitle)
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .regular))
                                .multilineTextAlignment(.center)
                        }
                    }
                })
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                
                if viewModel.selection != viewModel.rows.count {
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            if viewModel.selection != viewModel.rows.count {
                                
                                viewModel.selection += 1
                            }
                        }
                        
                    }, label: {
                        
                        Text("Next")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("green")))
                            .padding()
                    })
                } else {
                    
                    NavigationLink(destination: {
                        
                        BaseCurrencyView()
                            .navigationBarBackButtonHidden()
                        
                    }, label: {
                        
                        Text("Next")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("green")))
                            .padding()
                    })
                }
            }
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
