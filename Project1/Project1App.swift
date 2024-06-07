//
//  Project1App.swift
//  Project1
//
//  Created by Pieter Jooste on 2024/06/03.
//

import SwiftUI
import Firebase
import SwiftfulFirebaseAuth

@main
struct Project1 : App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @State private var appController = AppController()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(appController)
//                .onAppear {
//                    appController.listenToAuthChanges()
//                }
                .usesErrorAlert()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
