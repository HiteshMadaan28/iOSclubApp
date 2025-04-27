//
//  ChatMessage.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 27/04/25.
//

import Foundation
import FirebaseFirestore

struct ChatMessage: Identifiable, Codable {
    @DocumentID var id: String? // Document ID from Firestore
    var lastMessage: String
    var receiverID: String
    var senderID: String
    var timestamp: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case lastMessage
        case receiverID
        case senderID
        case timestamp
    }
}
