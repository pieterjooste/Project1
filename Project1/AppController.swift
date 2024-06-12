
//  SignInEmailViewModel.swift
//  Project1
//
//  Created by Pieter Jooste on 2024/06/03.
//

import SwiftUI
import FirebaseAuth


//enum AuthState {
//    case undefined, authenticated, notAuthenticated
//}

@Observable
class AppController {
    
    var email = ""
    var password = ""
    
//    var authState: AuthState = .undefined
//    
//    func listenToAuthChanges() {
//        Auth.auth().addStateDidChangeListener { auth, user in
//            self.authState = user != nil ? .authenticated : .notAuthenticated
//        }
//    }
    
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
//    
//    func signOut() throws {
//        try Auth.auth().signOut()
//    }
    
    func getUserProfile() {
        let user = Auth.auth().currentUser
        
        if let user {
            let uid = user.uid
            let email = user.email
//            let photoURL = user.photoURL
        }
    }
    
    func updateUserProfile() {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = "Ada"
        changeRequest?.commitChanges(completion: {error in
            if let error {
                print(error.localizedDescription)
            }
        })
    }
    
    func setUserEmail() {
        Auth.auth().currentUser?.updateEmail(to: "hello2@testing.com", completion: {error in
            if let error {
                print(error.localizedDescription)
            }
        })
    }
    
    func reAuthenticate() {
        let user = Auth.auth().currentUser
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        
        user?.reauthenticate(with: credential, completion: { result, error in
            if let error {
                print(error.localizedDescription)
            }
            print(result)
        })
    }
    
    func sendUserEmailVerification() {
        Auth.auth().currentUser?.sendEmailVerification(completion: { error in
            if let error {
                print(error.localizedDescription)
            }
        })
    }
    
    func setUserPassword() {
        Auth.auth().currentUser?.updatePassword(to: "asdfgh", completion: { error in
            if let error {
                print(error.localizedDescription)
            }
        })
    }
    
    func sendResetPasswordEmail() {
        Auth.auth().sendPasswordReset(withEmail: "jpjooste@mweb.co.za", completion: { error in
            if let error {
                print(error.localizedDescription)
            }
        })
    }
    
    func deleteUser() {
        let user = Auth.auth().currentUser
        
        user?.delete(completion: { error in
            if let error {
                print(error.localizedDescription)
            }
        })
    }
}
