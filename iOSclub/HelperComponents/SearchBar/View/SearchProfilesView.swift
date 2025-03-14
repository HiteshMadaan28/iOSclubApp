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
                        .onChange(of: viewModel.searchText) { newValue in
                            if !newValue.isEmpty {
                                viewModel.filterProfiles(with: newValue) // Trigger filter when text changes
                            } else {
                                viewModel.filteredProfiles = [] // Clear results when search is empty
                            }
                        }
                    
                    // Clear button to reset search text
                    if !viewModel.searchText.isEmpty {
                        Button(action: {
                            viewModel.searchText = "" // Reset search text
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
                .padding(.top,20)
                
                // MARK: - List or Empty State
                if viewModel.searchText == "" || viewModel.filteredProfiles.isEmpty {
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
                        .padding(.bottom,30)
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
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: profile.profile_image_url)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                case .failure(_):
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 50, height: 50)
                        .overlay(Text("?").font(.title))
                case .empty:
                    ProgressView()
                        .frame(width: 50, height: 50)
                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(profile.name)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(profile.is_connected ? "Connected" : "Not connected")
                    .font(.subheadline)
                    .foregroundColor(profile.is_connected ? .green : .gray)
            }

            Spacer()
            
            Button(action: connectAction) {
                Text(profile.is_connected ? "Connected" : "Connect")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(profile.is_connected ? Color.gray : Color.blue)
                    .cornerRadius(8)
            }
            .disabled(profile.is_connected)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 3)
    }
}


#Preview {
    SearchProfilesView()
}
