//
//  AuthenticationManager.swift
//  Project1
//
//  Created by Pieter Jooste on 2024/06/06.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
//    let isAnonymus : Bool?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
//        self.isAnonymus = user.isAnonymous
    }
}

enum AuthProviderOption: String {
    case email = "password"
    case google = "google.com"
    case apple = "apple.com"
}

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() { }
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.resourceUnavailable)
        }
        return AuthDataResultModel(user: user)
    }
    
    func getProviders() throws -> [AuthProviderOption ]{
        guard let providerData = Auth.auth().currentUser?.providerData else {
            throw URLError(.badServerResponse)
        }
        
        var providers: [AuthProviderOption] = []
        for provider in providerData {
            if let option = AuthProviderOption(rawValue: provider.providerID) {
                providers.append(option)
            } else {
                assertionFailure("Provider option not found: \(provider.providerID)")
            }
        }
        
        return providers
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func delete() async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        
        try await user.delete()
    }
}

//MARK: SIGN IN EMAIL

extension AuthenticationManager {
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func updatePassword(password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.userAuthenticationRequired)
        }
        
        try await user.updatePassword(to: password)
    }
    
//    func updateEmail(email: String) async throws {
//        guard let user = Auth.auth().currentUser else {
//            throw URLError(.userAuthenticationRequired)
//        }
//
//        try await user.updateEmail(to: email)
//
//        try await user.sendEmailVerification(beforeUpdatingEmail: email)
//    }
}


//MARK: SIGN IN SSO

extension AuthenticationManager {
    
//    @discardableResult
//    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
//        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
//        return try await signIn(credential: credential)
//    }
//    
//    @discardableResult
//    func signInWithApple(tokens: SignInWithAppleResult) async throws -> AuthDataResultModel {
//        let credential = OAuthProvider.credential(withProviderID: AuthProviderOption.apple.rawValue, idToken: tokens.token, rawNonce: tokens.nonce)
//        return try await signIn(credential: credential)
//    }
    
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
}
