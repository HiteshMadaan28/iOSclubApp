//
//  ConnectionContentView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 03/03/25.
//

import SwiftUI

struct ConnectionContentView: View {
    @State private var navigateToProfile = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(1..<10, id: \..self) { _ in
                            PostView()
                        }
                    }
                    .padding()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        navigateToProfile = true
                    }) {
                        Image("profile_pic") // Replace with user's profile image
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    }
                    .background(Color.red)
                }
            }
            .navigationDestination(isPresented: $navigateToProfile) {
                ProfileView()
            }
        }
    }
}

struct ProfileView: View {
    var body: some View {
        VStack {
            Image("banner") // Replace with actual banner image
                .resizable()
                .frame(height: 150)
                .overlay(
                    Image("profile_pic")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .offset(y: 50)
                )
                .padding(.bottom, 40)
            
            Text("John Doe")
                .font(.title)
                .fontWeight(.bold)
            Text("iOS Developer | Swift Enthusiast")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom)
            
            // Experience & Education Sections
            List {
                Section(header: Text("Experience")) {
                    Text("Senior iOS Developer at XYZ")
                }
                Section(header: Text("Education")) {
                    Text("Bachelor of Computer Science")
                }
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PostView: View {
    @State private var liked = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("profile_pic")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text("John Doe")
                        .font(.headline)
                    Text("2h ago")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                Button(action: { liked.toggle() }) {
                    Image(systemName: liked ? "heart.fill" : "heart")
                        .foregroundColor(liked ? .red : .gray)
                }
            }
            .padding(.bottom, 5)
            
            Text("This is a sample post. SwiftUI is awesome!")
                .font(.body)
                .padding(.bottom, 5)
            
            HStack {
                Button(action: { liked.toggle() }) {
                    Image(systemName: "heart")
                    Text("Like")
                }
                Spacer()
                Button(action: {}) {
                    Image(systemName: "message")
                    Text("Comment")
                }
            }
            .font(.subheadline)
            .foregroundColor(.gray)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemBackground)))
        .shadow(radius: 2)
    }
}
