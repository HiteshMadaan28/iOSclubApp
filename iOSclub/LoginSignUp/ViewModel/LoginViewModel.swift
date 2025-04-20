//
//  LoginViewModel.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 20/04/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class LoginViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var isAuthenticated = false

    private let db = Firestore.firestore()

    func login(email: String, password: String) {
        errorMessage = nil

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }

            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }

            guard let user = result?.user else {
                self.errorMessage = "Unexpected error: No user returned."
                return
            }

            // Fetch user data from Firestore (if needed)
            self.db.collection("users").document(user.uid).getDocument { snapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to fetch user data: \(error.localizedDescription)"
                    return
                }

                if snapshot?.exists == false {
                    // If user doc doesn't exist, create one
                    self.db.collection("users").document(user.uid).setData([
                        "email": email,
                        "uid": user.uid,
                        "createdAt": FieldValue.serverTimestamp()
                    ])
                }

                self.isAuthenticated = true
            }
        }
    }
}
