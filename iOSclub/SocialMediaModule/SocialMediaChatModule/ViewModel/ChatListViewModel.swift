//
//  ChatListViewModel.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 27/04/25.
//

import Foundation
import SwiftUI
import Combine
import FirebaseFirestore

class ChatListViewModel: ObservableObject {
    @Published var chatMessages: [ChatMessage] = []
    @Published var users: [UserProfile] = []
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    private let db = Firestore.firestore()
    
    init() {
        fetchChats()
        fetchUsers()
    }
    
    func fetchChats() {
        db.collection("chats")
            .order(by: "timestamp", descending: true) // fetch latest chats first
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    print("Error fetching chats: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else { return }
                
                DispatchQueue.main.async {
                    self?.chatMessages = documents.compactMap { doc in
                        try? doc.data(as: ChatMessage.self)
                    }
                }
            }
    }

    func fetchUsers() {
        db.collection("users")
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    print("Error fetching users: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else { return }
                
                DispatchQueue.main.async {
                    self?.users = documents.compactMap { doc in
                        let data = doc.data()
                        
                        let id = doc.documentID
                        let name = data["username"] as? String ?? "Unknown"
                        let profileImageURL = data["profilePhotoURL"] as? String
                        
                        return UserProfile(
                            id: id,
                            name: name,
                            profileImageURL: profileImageURL
                        )
                    }
                }
            }
    }

}
