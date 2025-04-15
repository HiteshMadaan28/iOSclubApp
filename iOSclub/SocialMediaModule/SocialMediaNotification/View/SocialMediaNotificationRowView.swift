//
//  SocialMediaNotificationRowView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 16/04/25.
//

import SwiftUI

struct SocialMediaNotificationRowView: View {
    let notification: SocialMediaNotificationModel

        var body: some View {
            HStack(alignment: .top, spacing: 12) {
                Image(notification.userImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 42, height: 42)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text("\(notification.username)")
                        .font(.system(size: 15, weight: .semibold)) +
                    Text(" \(notification.message)")
                        .font(.system(size: 15))

                    Text("Laborum aliqua do nostrud ...")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    Text(notification.time)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)

                    if notification.isUnread {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 8, height: 8)
                    }
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(notification.isUnread ? Color(UIColor.systemGray6) : Color.clear)
        }
}
