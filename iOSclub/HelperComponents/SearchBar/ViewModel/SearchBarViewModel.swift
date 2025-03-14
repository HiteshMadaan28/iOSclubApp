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
    let id: UUID
    let name: String
    let profile_image_url: String
    var is_connected: Bool = false
    
    // Custom keys if JSON field names differ
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profile_image_url
        case is_connected
    }
}

// MARK: - ViewModel
final class SearchBarViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var searchText: String = ""
    @Published var profiles: [Profile] = []
    @Published var filteredProfiles: [Profile] = []
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let debounceDelay: TimeInterval = 0.5
    
    private let apiBaseURL = "https://jgjldpbanbvqmjzcndit.supabase.co/rest/v1/profiles"
    private let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpnamxkcGJhbmJ2cW1qemNuZGl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk0MTg3NjEsImV4cCI6MjA1NDk5NDc2MX0.tLZ_9mQUOxeZAPuSLPml3lR3CNsOm_yDkGmN2y9rSME"
    
    // MARK: - Initialization
    init() {
        setupSearchSubscription()
        fetchProfiles() // Load profiles initially (optional)
    }
    
    // MARK: - Setup Search Debounce
    private func setupSearchSubscription() {
        $searchText
            .debounce(for: .seconds(debounceDelay), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self = self else { return }
                self.filterProfiles(with: query)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Fetch Profiles from Supabase
    func fetchProfiles(query: String? = nil) {
        guard let url = URL(string: apiBaseURL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(apiKey)", forHTTPHeaderField: "apikey")
        
        isLoading = true
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
            }
            
            if let error = error {
                print("❌ Error fetching profiles: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("❌ No data received.")
                return
            }
            
            do {
                let decodedProfiles = try JSONDecoder().decode([Profile].self, from: data)
                
                DispatchQueue.main.async {
                    self?.profiles = decodedProfiles
                    if let query = query, !query.isEmpty {
                        self?.filterProfiles(with: query) // Filter profiles after fetching if a query exists
                    } else {
                        self?.filteredProfiles = decodedProfiles // Show all profiles if no query
                    }
                }
            } catch {
                print("❌ Decoding error: \(error)")
            }
            
        }.resume()
    }

    // MARK: - Filter Profiles (Prioritize "starts with" over "contains")
    func filterProfiles(with query: String) {
        // If the query is empty, reset the filtered profiles to show all profiles
        guard !query.isEmpty else {
            self.filteredProfiles = self.profiles
            return
        }
        
        // Convert the query to lowercase for case-insensitive comparison
        let lowercaseQuery = query.lowercased()
        
        // Filter profiles that start with the query
        let startsWithMatches = profiles.filter {
            $0.name.lowercased().hasPrefix(lowercaseQuery)
        }
        
        // Filter profiles that contain the query but don't start with it
        let containsMatches = profiles.filter {
            !$0.name.lowercased().hasPrefix(lowercaseQuery) && $0.name.lowercased().contains(lowercaseQuery)
        }
        
        // Combine both filters: those that start with the query and those that contain it
        self.filteredProfiles = startsWithMatches + containsMatches
    }

    
    // MARK: - Connect Action
    func connect(to profile: Profile) {
        guard let index = profiles.firstIndex(where: { $0.id == profile.id }) else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.profiles[index].is_connected = true
            self.filterProfiles(with: self.searchText)
        }
        
        // ✅ Call your Supabase API to update `is_connected` if needed
    }
}
