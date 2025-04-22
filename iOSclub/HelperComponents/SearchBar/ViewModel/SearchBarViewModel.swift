//
//  SearchBarViewModel.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 14/03/25.
//

import Foundation
import Combine
import SwiftUI

// MARK: - Profile Model
struct Profile: Identifiable, Codable {
    var id: String // Firebase document ID
    var name: String // Maps to `username`
    var profile_image_url: String // Maps to `profilePhotoURL`
    var is_connected: Bool = false
}


// MARK: - ViewModel
import FirebaseFirestore
import Combine
import FirebaseAuth

final class SearchBarViewModel: ObservableObject {

    @Published var searchText: String = ""
    @Published var profiles: [Profile] = []
    @Published var filteredProfiles: [Profile] = []
    @Published var isLoading: Bool = false

    private var cancellables = Set<AnyCancellable>()
    private let debounceDelay: TimeInterval = 0.5
    private let db = Firestore.firestore()

    init() {
        setupSearchSubscription()
        fetchProfiles()
    }

    private func setupSearchSubscription() {
        $searchText
            .debounce(for: .seconds(debounceDelay), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.filterProfiles(with: query)
            }
            .store(in: &cancellables)
    }

    func fetchProfiles() {
        isLoading = true

        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("❌ Current user ID not found.")
            isLoading = false
            return
        }

        db.collection("users").getDocuments { [weak self] snapshot, error in
            DispatchQueue.main.async {
                self?.isLoading = false
            }

            if let error = error {
                print("❌ Error fetching users: \(error.localizedDescription)")
                return
            }

            guard let documents = snapshot?.documents else {
                print("❌ No user documents found.")
                return
            }

            let fetchedProfiles: [Profile] = documents.compactMap { doc in
                let data = doc.data()
                let userID = doc.documentID

                guard userID != currentUserID, // ✅ Exclude current user
                      let username = data["username"] as? String,
                      let photoURL = data["profilePhotoURL"] as? String else {
                    return nil
                }

                return Profile(
                    id: userID,
                    name: username,
                    profile_image_url: photoURL
                )
            }

            DispatchQueue.main.async {
                self?.profiles = fetchedProfiles
                self?.filterProfiles(with: self?.searchText ?? "")
            }
        }
    }


    func filterProfiles(with query: String) {
        guard !query.isEmpty else {
            filteredProfiles = profiles
            return
        }

        let lowercaseQuery = query.lowercased()

        let startsWith = profiles.filter { $0.name.lowercased().hasPrefix(lowercaseQuery) }
        let contains = profiles.filter {
            !$0.name.lowercased().hasPrefix(lowercaseQuery) &&
            $0.name.lowercased().contains(lowercaseQuery)
        }

        filteredProfiles = startsWith + contains
    }

    func connect(to profile: Profile) {
        guard let index = profiles.firstIndex(where: { $0.id == profile.id }) else { return }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.profiles[index].is_connected = true
            self.filterProfiles(with: self.searchText)
        }

        // 🔄 You can also update Firestore to mark as connected if needed.
    }
}

