//
//  SocialMediaNotificationModel.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 16/04/25.
//

import Foundation

enum SocialMediaNotificationType: String, Codable {
    case liked, addedPhoto, commented, tagged, mentioned
}

struct SocialMediaNotificationModel: Identifiable, Hashable {
    let id = UUID()
    let username: String
    let message: String
    let time: String
    let isUnread: Bool
    let userImage: String
    let section: SocialMediaNotificationSection
}

enum SocialMediaNotificationSection: String {
    case recent = "RECENTLY"
    case older = "OLDER"
}
