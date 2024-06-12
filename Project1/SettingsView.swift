//
//  SettingsView.swift
//  Project1
//
//  Created by Pieter Jooste on 2024/06/06.
//

import SwiftUI

struct SettingsView: View {
//    @Environment(AppController.self) private var appController
    @StateObject var viewModel = AuthenticationViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            Text("SettingsView")
            
            Button("Logout") {
                do {
                    try viewModel.signOut()
                    showSignInView = true
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
//    func signOut() throws {
//        try AuthenticationManager.shared.signOut()
//    }
}

#Preview {
    NavigationStack {
        SettingsView(showSignInView: .constant(false))
    }
    
}
