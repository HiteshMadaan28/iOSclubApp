//
//  ChatListView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 27/04/25.
//

import SwiftUI

struct ChatListView: View {
    @StateObject private var viewModel = ChatListViewModel()
    
    var body: some View {
        VStack {
            // Search
            TextField("Search", text: $viewModel.searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            // Horizontal scroll of users
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(viewModel.users) { user in
                        UserProfileRow(user: user)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical, 8)
            
            // Chats List
            List {
                ForEach(viewModel.chatMessages) { message in
                    ChatRowView(message: message)
                }
            }
            .listStyle(PlainListStyle())
        }
        .navigationTitle("Chats")
    }
}

