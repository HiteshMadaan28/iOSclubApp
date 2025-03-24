//
//  User.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 24/03/25.
//

import Foundation

struct User: Identifiable {
    let id: String
    let name: String
    let email: String
    let provider: AuthProvider
    
    enum AuthProvider {
        case email
        case apple
        case google
    }
}
