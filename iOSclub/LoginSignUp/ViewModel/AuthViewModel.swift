//
//  AuthViewModel.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 24/03/25.
//

import Foundation
import Combine
import SwiftUI
import Supabase
import AuthenticationServices

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
    
    func signInWithSupabase(identityToken: String, appleID: String, email: String, firstName: String, lastName: String) {
        Task {
            do {
                // Initialize Supabase client
                let supabase = SupabaseClient(
                    supabaseURL: URL(string: "https://jgjldpbanbvqmjzcndit.supabase.co/rest/v1/users")!,
                    supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpnamxkcGJhbmJ2cW1qemNuZGl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk0MTg3NjEsImV4cCI6MjA1NDk5NDc2MX0.tLZ_9mQUOxeZAPuSLPml3lR3CNsOm_yDkGmN2y9rSME"
                )
                
                // Sign in to Supabase with Apple credentials
                let authResponse = try await supabase.auth.signInWithIdToken(
                    credentials: .init(provider: .apple, idToken: identityToken)
                )
                
                // Save or update the user in the users table
                let user = authResponse.user
                await saveUserToSupabase(appleID: appleID, email: email, firstName: firstName, lastName: lastName)
                
                print("Supabase Sign-in Success:", user)

            } catch {
                print("Supabase Sign-in Error:", error.localizedDescription)
            }
        }
    }

    // Function to save or update the user in Supabase
    func saveUserToSupabase(appleID: String, email: String, firstName: String, lastName: String) async {
        do {
            // Insert or update the user in the users table
            let supabase = SupabaseClient(
                supabaseURL: URL(string: "https://jgjldpbanbvqmjzcndit.supabase.co/rest/v1/users")!,
                supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpnamxkcGJhbmJ2cW1qemNuZGl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk0MTg3NjEsImV4cCI6MjA1NDk5NDc2MX0.tLZ_9mQUOxeZAPuSLPml3lR3CNsOm_yDkGmN2y9rSME"
            )
            
            try await supabase.from("users").upsert([
                "apple_id": appleID,
                "email": email,
                "first_name": firstName,
                "last_name": lastName,
                "name": "\(firstName) \(lastName)"  // Optional: Concatenate first and last name
            ])
            
            print("✅ User saved to Supabase")
            
        } catch {
            print("❌ Error saving user to Supabase: \(error.localizedDescription)")
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
