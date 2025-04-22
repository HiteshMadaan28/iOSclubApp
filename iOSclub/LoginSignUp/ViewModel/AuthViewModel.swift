//
//  AuthViewModel.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 19/04/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var username: String = "" // Only used in Sign Up
    @Published var isSignedIn: Bool = false
    @Published var errorMessage: String = ""
    
    @Published var currentUser: User?
    @Published var users: [User] = [] // <-- Store all users
    
    static var shared = AuthViewModel()
    
    private let db = Firestore.firestore()
    
    init() {
        isSignedIn = Auth.auth().currentUser != nil
        if let user = Auth.auth().currentUser {
            loadUser(uid: user.uid)
        }
    }
    
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = "Signup error: \(error.localizedDescription)"
                return
            }

            guard let user = result?.user else { return }
            
            // Create user data
            let userData: [String: Any] = [
                "email": self.email,
                "username": self.username,
                "profilePhotoURL": "",  // Set default or empty
                "bannerImageURL": "",   // Set default or empty
                "bio": "",
                "dateOfBirth": "",
                "location": "",
                "phoneNumber": "",
                "gender": "",
                "websiteURL": "",
                "socialMediaLinks": [
                    "twitter": "",
                    "instagram": ""
                ],
                "joinDate": Timestamp(date: Date()),
                "lastActive": Timestamp(date: Date()),
                "status": "",
                "followersCount": 0,
                "followingCount": 0,
                "postsCount": 0,
                "likesCount": 0,
                "commentsCount": 0,
                "interests": [],
                "privacySettings": [
                    "profileVisibility": "public",
                    "postVisibility": "friends"
                ],
                "badges": [],
                "deviceInfo": [
                    "deviceModel": "Unknown",
                    "os": "Unknown"
                ]
            ]
            
            // Save user data to Firestore
            self.db.collection("users").document(user.uid).setData(userData) { err in
                if let err = err {
                    self.errorMessage = "Firestore error: \(err.localizedDescription)"
                    return
                }
                DispatchQueue.main.async {
                    self.currentUser = User(id: user.uid, email: self.email, username: self.username)
                    self.isSignedIn = true
                }
            }
        }
    }

    
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = "Signin error: \(error.localizedDescription)"
                return
            }
            guard let user = result?.user else { return }
            self.loadUser(uid: user.uid)
        }
    }
    
    func loadUser(uid: String) {
        db.collection("users").document(uid).getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                let email = data?["email"] as? String ?? "unknown"
                let username = data?["username"] as? String ?? "unknown"
                
                DispatchQueue.main.async {
                    self.currentUser = User(id: uid, email: email, username: username)
                    self.isSignedIn = true
                }
            } else {
                print("User document not found.")
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isSignedIn = false
            self.currentUser = nil
            self.email = ""
            self.password = ""
            self.username = ""
        } catch {
            self.errorMessage = "Signout failed: \(error.localizedDescription)"
        }
    }
    
    // ✅ Fetch all users from Firestore
    func fetchAllUsers() {
        db.collection("users").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching users: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            DispatchQueue.main.async {
                self.users = documents.compactMap { doc in
                    let data = doc.data()
                    let uid = doc.documentID
                    let email = data["email"] as? String ?? "unknown"
                    let username = data["username"] as? String ?? "unknown"
                    return User(id: uid, email: email, username: username)
                }
            }
        }
    }
}
