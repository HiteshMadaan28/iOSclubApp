//
//  UserProfile.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 27/04/25.
//
import Foundation

struct UserProfile: Identifiable, Codable {
    var id: String
    var name: String
    var profileImageURL: String?
    
    // Optional custom initializer if needed
    init(id: String, name: String, profileImageURL: String? = nil) {
        self.id = id
        self.name = name
        self.profileImageURL = profileImageURL
    }
    
    // If you're fetching from a Firebase document, you can use a Codable initializer (optional if you need)
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profileImageURL
    }
}
