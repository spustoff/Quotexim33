//
//  RatesView.swift
//  Quotex33
//
//  Created by Вячеслав on 12/12/22.
//

import SwiftUI

struct RatesView: View {
    
    @StateObject var viewModel = RatesViewModel()
    @Namespace var animation
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                VStack {
                 
                    ZStack {
                        
                        Text("Rates")
                            .foregroundColor(.white)
                            .font(.system(size: 21, weight: .semibold))
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.list = true
                            }
                            
                        }, label: {
                            
                            HStack {
                                
                                Text(viewModel.selectedPair)
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .semibold))
                                
                                Image(systemName: "chevron.down")
                                    .foregroundColor(Color("green"))
                                    .font(.system(size: 15, weight: .regular))
                            }
                        })
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    
                    Divider()
                }
                .padding()
                
                LazyHStack {
                    
                    ForEach(viewModel.intervals, id: \.self) { index in
                        
                        VStack {
                            
                            Text("\(index)m")
                                .foregroundColor(viewModel.selectedInterval != index ? .gray : .white)
                                .font(.system(size: 16, weight: .semibold))
                            
                            if viewModel.selectedInterval == index {
                                
                                Rectangle()
                                    .fill(Color("green"))
                                    .frame(height: 2)
                                    .matchedGeometryEffect(id: "tab", in: animation)
                            }
                        }
                        .padding()
                        .onTapGesture {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.selectedInterval = index
                            }
                        }
                    }
                }
                .frame(height: 40)
                
                WebView(pair: viewModel.selectedPair, interval: viewModel.selectedInterval)
                    .disabled(true)
                    .padding(.bottom, 50)
                
                Spacer()
            }
        }
        .sheet(isPresented: $viewModel.list, content: {
            
            PairListView(viewModel: viewModel)
        })
    }
}

struct RatesView_Previews: PreviewProvider {
    static var previews: some View {
        RatesView()
    }
}
