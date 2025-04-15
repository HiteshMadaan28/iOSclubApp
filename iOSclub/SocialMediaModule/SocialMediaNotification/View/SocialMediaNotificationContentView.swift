//
//  SocialMediaNotificationContentView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 15/04/25.
//

import SwiftUI

struct SocialMediaNotificationContentView: View {
    @StateObject private var viewModel = NotificationViewModel()
    @State private var selectedTab: String = "All"

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Spacer()
                Text("Notifications")
                    .font(.system(size: 18, weight: .bold))
                Spacer()
                Image(systemName: "magnifyingglass")
                    .padding(.trailing)
            }
            .padding()

            // Tabs
            HStack(spacing: 20) {
                Button(action: { selectedTab = "All" }) {
                    Text("All")
                        .fontWeight(selectedTab == "All" ? .bold : .regular)
                        .foregroundColor(.black)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 16)
                        .background(selectedTab == "All" ? Color(UIColor.systemGray5) : Color.clear)
                        .cornerRadius(16)
                }

                Button(action: { selectedTab = "Unread" }) {
                    Text("Unread")
                        .fontWeight(selectedTab == "Unread" ? .bold : .regular)
                        .foregroundColor(.black)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 16)
                        .background(selectedTab == "Unread" ? Color(UIColor.systemGray5) : Color.clear)
                        .cornerRadius(16)
                }
                Spacer()
            }
            .padding(.horizontal)

            Divider()

            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    if !viewModel.recentNotifications.isEmpty {
                        Text("RECENTLY")
                            .font(.system(size: 13, weight: .semibold))
                            .padding(.horizontal)

                        ForEach(filteredNotifications(viewModel.recentNotifications)) {
                            SocialMediaNotificationRowView(notification: $0)
                        }
                    }

                    if !viewModel.olderNotifications.isEmpty {
                        Text("OLDER")
                            .font(.system(size: 13, weight: .semibold))
                            .padding(.horizontal)
                            .padding(.top, 8)

                        ForEach(filteredNotifications(viewModel.olderNotifications)) {
                            SocialMediaNotificationRowView(notification: $0)
                        }
                    }
                }
            }
        }
    }

    private func filteredNotifications(_ list: [SocialMediaNotificationModel]) -> [SocialMediaNotificationModel] {
        if selectedTab == "Unread" {
            return list.filter { $0.isUnread }
        }
        return list
    }
}

#Preview {
    SocialMediaNotificationContentView()
}
