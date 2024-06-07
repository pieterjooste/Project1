//
//  AuthenticationView.swift
//  Project1
//
//  Created by Pieter Jooste on 2024/06/03.
//

import SwiftUI
import FirebaseAuth

struct AuthView: View {
    
    @Environment(AppController.self) private var appController
    @Environment(\.errorAlert) private var errorAlert
    @Binding var showSignInView: Bool
    
    @State private var isSignUp = false
    
    var body: some View {
        VStack {
            TextField("Email...", text: Bindable(appController).email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Password...", text: Bindable(appController).password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button {
                authenticate()
                
            } label: {
                HStack {
                    Spacer()
                    Text("\(isSignUp ? "Register" : "Sign in")")
                    Spacer()
                }
            }
            .buttonStyle(.borderedProminent)
            
            Button("\(isSignUp ? "I already have an account" : "I don't have an account")") {
                isSignUp.toggle()
            }
        }
        .padding()
    }
    
    func authenticate() {
        isSignUp ? signUp() : signIn()
    }
    
    func signUp() {
        Task {
            do {
                try await appController.signUp()
                showSignInView = false
            } catch {
//                print(error.localizedDescription)
                await errorAlert.present(error, title: errorAlert.title ?? "Error", buttonTitle: errorAlert.buttonTitle ?? "OK", action: errorAlert.action)
            }
        }
    }
    
    func signIn() {
        Task {
            do {
                try await appController.signIn()
                showSignInView = false
            } catch {
//                print(error.localizedDescription)
                await errorAlert.present(error, title: errorAlert.title ?? "Error", buttonTitle: errorAlert.buttonTitle ?? "OK", action: errorAlert.action)
            }
        }
    }
    
    
}

#Preview {
    NavigationStack {
        AuthView(showSignInView: .constant(false))
    }
    
}
