//
//  TargetsView.swift
//  Quotex33
//
//  Created by Вячеслав on 12/12/22.
//

import SwiftUI

struct TargetsView: View {
    
    @StateObject var viewModel = TargetsViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                VStack {
                 
                    ZStack {
                        
                        Text("Targets")
                            .foregroundColor(.white)
                            .font(.system(size: 21, weight: .semibold))
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.showNewTarget = true
                            }
                            
                        }, label: {
                            
                            Image("add")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        })
                    }
                    
                    Divider()
                }
                .padding()
                
                if viewModel.targets.isEmpty {
                    
                    VStack {
                        
                        Image("emptytargets")
                        
                        Text("No targets")
                            .foregroundColor(.gray)
                            .font(.system(size: 25, weight: .semibold))
                        
                        Text("Create your first target")
                            .foregroundColor(.gray)
                            .font(.system(size: 18, weight: .regular))
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxHeight: .infinity, alignment: .center)
                } else {
                    
                    if viewModel.isLoading {
                        
                        ProgressView()
                            .frame(maxHeight: .infinity, alignment: .center)
                        
                    } else {
                        
                        ScrollView(.vertical, showsIndicators: true) {
                            
                            LazyVStack {
                                
                                ForEach(viewModel.targets) { target in
                                    
                                    VStack{
                                        
                                        HStack{
                                            
                                            Text(target.title)
                                                .foregroundColor(.white)
                                                .font(.system(size: 18, weight: .semibold))
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                
                                                withAnimation(.spring()){
                                                    
                                                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                                                    impactLight.impactOccurred()
                                                    
                                                    viewModel.selectedTarget = target
                                                    viewModel.showAddDeposit = true
                                                }
                                                
                                            }, label: {
                                                
                                                Image(systemName: "plus")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 18, weight: .regular))
                                            })
                                            
                                            Button(action: {
                                                
                                                withAnimation(.spring()){
                                                    
                                                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                                                    impactLight.impactOccurred()
                                                    
                                                    viewModel.removeFromTargets(name: target.title)
                                                }
                                                
                                            }, label: {
                                                
                                                Image(systemName: "trash")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 18, weight: .regular))
                                            })
                                        }
                                        
                                        ZStack(alignment: .leading){
                                            
                                            RoundedRectangle(cornerRadius: 4)
                                                .fill(Color.gray.opacity(0.2))
                                                .frame(width: UIScreen.main.bounds.width - 30, height: 10)
                                            
                                            let size = UIScreen.main.bounds.width - 30
                                            
                                            RoundedRectangle(cornerRadius: 4)
                                                .fill(Color("green"))
                                                .frame(width: size * CGFloat(target.currentCount) / CGFloat(target.totalCount))
                                                .frame(height: 10)
                                        }
                                        
                                        HStack{
                                            
                                            Text("$\(target.currentCount)")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 14, weight: .regular))
                                            
                                            Spacer()
                                            
                                            Text("$\(target.totalCount)")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 14, weight: .regular))
                                        }
                                        
                                        Divider()
                                    }
                                    .padding()
                                }
                            }
                        }
                        .padding(.bottom, 51)
                    }
                }
                
                Spacer()
            }
        }
        .sheet(isPresented: $viewModel.showNewTarget, content: {
            
            NewTargetView()
        })
        .overlay(
        
            addDeposit()
                .opacity(viewModel.showAddDeposit ? 1 : 0)
            
        )
    }
    
    @ViewBuilder
    func addDeposit() -> some View {
        
        ZStack{
            
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    
                    withAnimation(.spring()){
                        
                        let impactLight = UIImpactFeedbackGenerator(style: .light)
                        impactLight.impactOccurred()
                        
                        viewModel.showAddDeposit = false
                        
                        UIApplication.shared.endEditing()
                    }
                }
            
            VStack{
                
                ZStack{
                 
                    VStack{
                        
                        HStack{
                            
                            Button(action: {
                                
                                withAnimation(.spring()){
                                    
                                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                                    impactLight.impactOccurred()
                                    
                                    viewModel.showAddDeposit = false
                                    
                                    UIApplication.shared.endEditing()
                                }
                                
                            }, label: {
                                
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .regular))
                                    .frame(width: 30, height: 30)
                                    .background(Circle().fill(Color.gray.opacity(0.1)))
                            })
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            VStack{
                                
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(width: 45, height: 5)
                                
                                Text("Deposit")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            
                            Button(action: {
                                
                                withAnimation(.spring()){
                                    
                                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                                    impactLight.impactOccurred()
                                                                        
                                    viewModel.addDeposit()
                                    
                                    UIApplication.shared.endEditing()
                                }
                                
                            }, label: {
                                
                                Text("Done")
                                    .foregroundColor(Color("green"))
                                    .font(.system(size: 15, weight: .semibold))
                            })
                            .disabled(viewModel.depositCount.isEmpty ? true : false)
                            .opacity(viewModel.depositCount.isEmpty ? 0.5 : 1)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .padding()
                        
                        VStack{
                            
                            ZStack(alignment: .leading){
                                
                                Text("$100")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .semibold))
                                    .opacity(viewModel.depositCount.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.depositCount)
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .semibold))
                                    .keyboardType(.decimalPad)
                            }
                            
                            Rectangle()
                                .fill(viewModel.depositCount.isEmpty ? Color.gray.opacity(0.3) : Color("green"))
                                .frame(height: 1)
                        }
                        .padding()
                        
                        Spacer()
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 30, height: 150)
                .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg")))
            }
        }
    }
}

struct TargetsView_Previews: PreviewProvider {
    static var previews: some View {
        TargetsView()
    }
}
