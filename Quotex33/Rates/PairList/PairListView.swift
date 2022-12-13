//
//  PairListView.swift
//  Quotex33
//
//  Created by Вячеслав on 12/12/22.
//

import SwiftUI

struct PairListView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: RatesViewModel
    
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
                
                switch viewModel.isLoading {
                    
                case true:
                    VStack {
                        
                        ProgressView()
                        
                        Text("is loading...")
                            .foregroundColor(.gray)
                            .font(.system(size: 13, weight: .regular))
                    }
                    .frame(maxHeight: .infinity, alignment: .center)
                    
                case false:
                    ScrollView(.vertical, showsIndicators: true) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.search.isEmpty ? viewModel.pairs.flatMap(\.currencies) : viewModel.pairs.flatMap(\.currencies).filter{$0.pair.lowercased().contains(viewModel.search.lowercased())}, id: \.self) { index in
                                
                                HStack{
                                    
                                    Text(viewModel.countryFlag(countryCode: String(String(index.pair.dropLast()).dropLast())))
                                        .foregroundColor(.white)
                                        .font(.system(size: 17, weight: .semibold))
                                    
                                    Text(index.pair)
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .semibold))
                                    
                                    Spacer()
                                    
                                    Text("\(index.price)")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                    
                                    Circle()
                                        .stroke(Color.gray, lineWidth: 1)
                                        .frame(width: 25, height: 25)
                                        .overlay(
                                        
                                            Circle()
                                                .fill(Color("green"))
                                                .frame(width: 20, height: 20)
                                                .opacity(viewModel.selectedPair == index.pair ? 1 : 0)
                                        
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
                                        
                                        viewModel.selectedPair = index.pair
                                        viewModel.pairs = []
                                        
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }
                            }
                        }
                    }
                    .padding(.bottom)
                }
                
                Spacer()
            }
            .padding(.top, 40)
            .ignoresSafeArea(.all, edges: .bottom)
        }
        .onAppear {
            
            if viewModel.pairs.isEmpty {
                
                viewModel.loadData()
            }
        }
    }
}
