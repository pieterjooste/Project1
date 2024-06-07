//
//  UserManager.swift
//  Project1
//
//  Created by Pieter Jooste on 2024/06/07.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class UserManager {
    
    static let shared = UserManager()
    private init() { }
    
    func createNewUser(auth:AuthDataResultModel) async throws {
        var userData: [String: Any] = [
            "user_id": auth.uid,
//            "is_anonymous": auth.isAnonymus,
            "data_created": Timestamp()
        ]
        if let email = auth.email {
            userData["email"] = email
        }
//        if let photoUrl = auth.photoUrl {
//            userData["photo_url"] = photoUrl
//        }

        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
    }
}
