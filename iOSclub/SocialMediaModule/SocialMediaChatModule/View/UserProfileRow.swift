//
//  UserProfileRow.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 27/04/25.
//

import SwiftUI

struct UserProfileRow: View {
    var user: UserProfile
    
    var body: some View {
        VStack {
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 60, height: 60)
            Text(user.name)
                .font(.caption)
        }
    }
}

