//
//  CustomTabBar.swift
//  zaglushka
//
//  Created by Вячеслав on 11/15/22.
//

import SwiftUI

struct CustomTabbar: View {
    
    @Namespace var animation
    
    @Binding var selectedTab : String
    
    @AppStorage("status") var status: Bool = false
    
    var body: some View {
        
        HStack{
            
            TabButton(title: "MyCurrencies", animation: animation, selectedTab: $selectedTab)
            
            TabButton(title: "Targets", animation: animation, selectedTab: $selectedTab)
            
            TabButton(title: "Add", animation: animation, selectedTab: $selectedTab)
            
            TabButton(title: "Rates", animation: animation, selectedTab: $selectedTab)
            
            TabButton(title: "Settings", animation: animation, selectedTab: $selectedTab)

        }
        .padding(.horizontal, 13)
        .padding(.bottom, 5)
        .background(
        
            Rectangle()
                .fill(Color("bg"))
                .frame(maxWidth: .infinity)
                .frame(height: 100)
        
        )
    }
}

struct TabButton : View {
    
    var title : String
    var animation: Namespace.ID
    
    @AppStorage("status") var status: Bool = false
    
    @Binding var selectedTab : String
    
    var body: some View{
        
        Button(action: {
            
            if selectedTab != title{
                
                selectedTab = title
                
                let impactLight = UIImpactFeedbackGenerator(style: .light)
                impactLight.impactOccurred()
            }
            
        }, label: {
            VStack(spacing: 2){
                
                ZStack{
                    
                    VStack{
                        
                        Image(title)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 27, height: 27)
                            .foregroundColor(selectedTab == title ? Color.white : .gray)
                    }
                    .frame(width: 51, height: 51)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom)
        })
        .disabled(selectedTab != title ? false : true)
    }
}

struct ScaledButtonStyle: ButtonStyle{
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
