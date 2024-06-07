//
//  SignInEmailViewModel.swift
//  Project1
//
//  Created by Pieter Jooste on 2024/06/03.
//

import SwiftUI
import FirebaseAuth

@Observable
final class SignInEmailViewModel: ObservableObject {
    
//    @Published var email = ""
//    @Published var password = ""
//    
//    func signUp() async throws {
//        guard !email.isEmpty, !password.isEmpty else{
//            print("No email or password found.")
//            return
//        }
//        let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
//        let user = DBUser(auth: authDataResult)
//        try await UserManager.shared.createNewUser(user: user)
//    }
//    
//    func signIn() async throws {
//        guard !email.isEmpty, !password.isEmpty else{
//            print("No email or password found.")
//            return
//        }
//        try await AuthenticationManager.shared.signInUser(email: email, password: password)
//    }
}
