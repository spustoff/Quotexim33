//
//  Quotex33App.swift
//  Quotex33
//
//  Created by Вячеслав on 12/11/22.
//

import SwiftUI
import Firebase
import Amplitude
import ApphudSDK

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        Apphud.start(apiKey: "app_bJGWGB1Z7soEBGDEFU97mEL5azSjCc")
        Amplitude.instance().initializeApiKey("11d30db201f33067999b4236fd0b1185")
        
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct Quotex33App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        
        WindowGroup {
            
            NavigationView(content: {
                
                ContentView()
            })
        }
    }
}
