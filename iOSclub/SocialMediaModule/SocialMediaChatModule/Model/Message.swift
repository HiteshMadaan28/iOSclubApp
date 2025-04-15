//
//  Message.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 16/04/25.
//

import Foundation

struct Message: Identifiable, Codable {
    let id = UUID()
    let text: String
    let isSentByUser: Bool
}
