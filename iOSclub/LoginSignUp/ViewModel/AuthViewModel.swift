//
//  AuthViewModel.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 24/03/25.
//

import Foundation
import Combine
import SwiftUI

final class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var errorMessage: String?
    
    // Email login/signup example
    func login(email: String, password: String) {
        // Your backend logic here
        print("Logging in with email: \(email)")
        user = User(id: UUID().uuidString, name: "Email User", email: email, provider: .email)
    }
    
    func signup(email: String, password: String, name: String) {
        // Your backend logic here
        print("Signing up with email: \(email)")
        user = User(id: UUID().uuidString, name: name, email: email, provider: .email)
    }
    
    func handleAppleSignIn() {
        AppleSignInManager.shared.signIn { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self.user = user
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
//    func handleGoogleSignIn() {
//        GoogleSignInManager.shared.signIn { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let user):
//                    self.user = user
//                case .failure(let error):
//                    self.errorMessage = error.localizedDescription
//                }
//            }
//        }
//    }
}
