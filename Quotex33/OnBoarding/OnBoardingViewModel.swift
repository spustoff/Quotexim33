//
//  OnBoardingViewModel.swift
//  Quotex33
//
//  Created by Вячеслав on 12/11/22.
//

import SwiftUI

final class OnBoardingViewModel: ObservableObject {
    
    @Published var rows: [OnBoardingModel] = [
    
        OnBoardingModel(id: 1, image: "on1", title: "Welcome!", subtitle: "Save money easily in our app"),
        OnBoardingModel(id: 2, image: "on2", title: "Rates", subtitle: "Let's gonna look to our rates!"),
        OnBoardingModel(id: 3, image: "on3", title: "Our pairs", subtitle: "We got many pairs in our app."),
    ]
    
    @Published var selection: Int = 1
}
