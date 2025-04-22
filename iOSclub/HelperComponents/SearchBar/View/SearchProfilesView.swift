//
//  SearchProfilesView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 14/03/25.
//

import SwiftUI

struct SearchProfilesView: View {
    
    @StateObject private var viewModel = SearchBarViewModel()

    var body: some View {
        VStack {
            // MARK: - Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search profiles...", text: $viewModel.searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)

                if !viewModel.searchText.isEmpty {
                    Button(action: {
                        viewModel.searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray.opacity(0.7))
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.top, 20)
            
            // MARK: - Results or Empty State
            if viewModel.isLoading {
                ProgressView("Loading profiles...")
                    .padding(.top, 60)
            } else if !viewModel.searchText.isEmpty && viewModel.filteredProfiles.isEmpty {
                VStack(spacing: 10) {
                    Image(systemName: "person.3.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .foregroundColor(.gray.opacity(0.5))
                    
                    Text("No profiles found")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                .padding(.top, 80)
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.filteredProfiles) { profile in
                            ProfileCard(profile: profile) {
                                viewModel.connect(to: profile)
                            }
                        }
                    }
                    .padding()
                    .padding(.bottom, 30)
                }
            }
            
            Spacer()
        }
    }
}


struct ProfileCard: View {
    let profile: Profile
    let connectAction: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            // Profile Image
            AsyncImage(url: URL(string: profile.profile_image_url)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                case .failure:
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 60, height: 60)
                        .overlay(Text("?").font(.title2).foregroundColor(.white))
                case .empty:
                    ProgressView()
                        .frame(width: 60, height: 60)
                @unknown default:
                    EmptyView()
                }
            }

            // Name + Status
            VStack(alignment: .leading, spacing: 6) {
                Text(profile.name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.primary)

                Text(profile.is_connected ? "Connected" : "Not connected")
                    .font(.system(size: 14))
                    .foregroundColor(profile.is_connected ? .green : .secondary)
            }

            Spacer()
            
            // Connect Button
            Button(action: connectAction) {
                Text(profile.is_connected ? "Connected" : "Connect")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(profile.is_connected ? Color.gray : Color.blue)
                    .cornerRadius(10)
            }
            .disabled(profile.is_connected)
            .animation(.easeInOut, value: profile.is_connected)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 4)
    }
}


#Preview {
    SearchProfilesView()
}
