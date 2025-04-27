//
//  ChatRowView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 27/04/25.
//

import SwiftUI

struct ChatRowView: View {
    var message: ChatMessage
    var user: UserProfile?

    var body: some View {
        HStack(spacing: 12) {
            profileImageView

            VStack(alignment: .leading, spacing: 4) {
                Text(user?.name ?? "Unknown User")
                    .font(.headline)
                Text(message.lastMessage)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(timeAgo(from: message.timestamp))
                    .font(.caption)
                    .foregroundColor(.gray)
                // No unread dot anymore
            }
        }
        .padding(.vertical, 8)
    }
    
    private var profileImageView: some View {
        Group {
            if let profileImageURL = user?.profileImageURL, let url = URL(string: profileImageURL) {
                AsyncImage(url: url) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                    }
                }
            } else {
                Circle()
                    .fill(Color.gray.opacity(0.3))
            }
        }
        .frame(width: 50, height: 50)
        .clipShape(Circle())
    }

    private func timeAgo(from date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}
