//
//  SocialMediaNotificationViewModel.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 16/04/25.
//

import Foundation

class NotificationViewModel: ObservableObject {
    @Published var notifications: [SocialMediaNotificationModel] = []

    init() {
        loadMockData()
    }

    func loadMockData() {
        notifications = [
            SocialMediaNotificationModel(username: "Jennie Ponce", message: "liked your video", time: "10m ago", isUnread: true, userImage: "profile_jennie", section: .recent),
            SocialMediaNotificationModel(username: "Sally Rooney", message: "added a photo", time: "10m ago", isUnread: true, userImage: "profile_sally", section: .recent),
            SocialMediaNotificationModel(username: "Liam Pham", message: "commented on your post", time: "20m ago", isUnread: true, userImage: "profile_liam", section: .recent),
            SocialMediaNotificationModel(username: "Kristin Watson", message: "liked your post", time: "10m ago", isUnread: false, userImage: "profile_kristin", section: .recent),
            SocialMediaNotificationModel(username: "Jena Nguyen", message: "tagged you in a photo", time: "Yesterday", isUnread: false, userImage: "profile_jena", section: .older),
            SocialMediaNotificationModel(username: "Anja O'Connor", message: "mentioned you in a comment", time: "10/02/2022", isUnread: false, userImage: "profile_anja", section: .older),
            SocialMediaNotificationModel(username: "Kristin Watson", message: "liked your post", time: "10m ago", isUnread: false, userImage: "profile_kristin", section: .older)
        ]
    }

    var recentNotifications: [SocialMediaNotificationModel] {
        notifications.filter { $0.section == .recent }
    }

    var olderNotifications: [SocialMediaNotificationModel] {
        notifications.filter { $0.section == .older }
    }
}
