//
//  SocialMediaProfileView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 11/03/25.
//

import SwiftUI

struct SocialMediaProfileView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var selectedTab: Tab = .posts
    @State private var isSearchPresented = false

    @ObservedObject var authViewModel = AuthViewModel.shared
    var viewedUser: User? // User whose profile is being viewed
    
    enum Tab {
        case posts
        case photos
    }

    private var isCurrentUser: Bool {
        guard let viewedUser = viewedUser else { return true }
        return viewedUser.id == authViewModel.currentUser?.id
    }
    
    var body: some View {
        NavigationStack {
            HStack(spacing: 0) {
                Button { dismiss() } label: {
                    Image("Chevron left")
                        .frame(width: 24, height: 24)
                        .padding(.leading, 14)
                }
                
                Spacer()

                if isCurrentUser {
                    Image("Search")
                        .padding(.trailing, 14)
                        .onTapGesture {
                            isSearchPresented.toggle()
                        }
                }
            }

            ScrollView {
                VStack(spacing: 0) {
                    // Banner and Avatar
                    ZStack {
                        Image("DemoBanner")
                            .resizable()
                            .cornerRadius(16, corners: [.topLeft, .topRight])
                            .frame(height: 150)
                            .padding(.horizontal, 24)

                        VStack(spacing: 0) {
                            Image("Avatar")
                                .resizable()
                                .frame(width: 160, height: 160)
                                .clipShape(Circle())
                        }
                        .offset(y: 80)
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 80)
                    
                    // Profile Info
                    let userToShow = isCurrentUser ? authViewModel.currentUser : viewedUser
                    
                    if let user = userToShow {
                        Text(user.username)
                            .font(.custom("Archivo", size: 20).bold())
                            .padding(.top, 18)
                        
                        // You can later bind real bio data from Firestore
                        Text("Photographer, travelholic, food lover and iOS Dev")
                            .font(.custom("Inter", size: 16))
                            .foregroundStyle(Color(hex: "9095A0"))
                            .padding(.top, 10)
                            .padding(.horizontal, 70)
                            .multilineTextAlignment(.center)
                    } else {
                        Text("Loading user data...")
                            .font(.custom("Archivo", size: 20).bold())
                            .padding(.top, 18)
                    }

                    if isCurrentUser {
                        // Actions for current user
                        HStack(spacing: 0) {
                            HStack(spacing: 0) {
                                Spacer()
                                Image("Check double")
                                Text("Following")
                                    .font(.custom("Inter", size: 14))
                                    .foregroundStyle(Color(hex: "7F55E0"))
                                    .padding(.leading, 6)
                                Spacer()
                            }
                            .frame(height: 36)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color(hex: "7F55E0"), lineWidth: 1)
                            )
                            
                            
                            Button {
                                authViewModel.signOut()
                            } label: {
                                HStack(spacing: 0) {
                                    Spacer()
                                    Image("Chat circle dots")
                                    Text("Logout")
                                        .font(.custom("Inter", size: 14))
                                        .foregroundStyle(.white)
                                        .padding(.leading, 6)
                                    Spacer()
                                }
                                .frame(height: 36)
                                .background(
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(Color(hex: "636AE8"))
                                )
                            }
                            .padding(.leading, 10)

                            HStack {
                                Image("More vert").padding(10)
                            }
                            .frame(height: 36)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color(hex: "9095A0"), lineWidth: 1)
                            )
                            .padding(.leading, 10)
                        }
                        .padding(.top, 18)
                        .padding(.horizontal, 24)

                        Divider().padding(.top, 25)

                        // Tab Section
                        HStack(spacing: 0) {
                            Spacer()
                            Button {
                                selectedTab = .posts
                            } label: {
                                HStack(spacing: 0) {
                                    Image("PostIcon")
                                        .renderingMode(.template)
                                        .foregroundStyle(selectedTab == .posts ? Color(hex: "7F55E0") : Color(hex: "424955"))
                                    Text("Posts")
                                        .foregroundStyle(selectedTab == .posts ? Color(hex: "7F55E0") : Color(hex: "424955"))
                                        .padding(.leading, 10.25)
                                }
                            }
                            Spacer()
                            Button {
                                selectedTab = .photos
                            } label: {
                                HStack(spacing: 0) {
                                    Image("ImageIcon")
                                        .renderingMode(.template)
                                        .foregroundStyle(selectedTab == .photos ? Color(hex: "7F55E0") : Color(hex: "424955"))
                                    Text("Photos")
                                        .foregroundStyle(selectedTab == .photos ? Color(hex: "7F55E0") : Color(hex: "424955"))
                                        .padding(.leading, 10.25)
                                }
                            }
                            Spacer()
                        }
                        .frame(height: 56)

                        Divider()

                        // Tab Content
                        VStack {
                            if selectedTab == .posts {
                                PostsSectionView()
                            } else {
                                PhotosSectionView()
                            }
                        }
                        .padding(.top, 20)
                        .padding(.horizontal, 24)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .sheet(isPresented: $isSearchPresented) {
                SearchProfilesView()
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
                    .presentationCornerRadius(21)
                    .padding(.top)
                    .ignoresSafeArea()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            authViewModel.fetchAllUsers()
        }
    }
}


#Preview {
    SocialMediaProfileView()
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    let radius: CGFloat
    let corners: UIRectCorner
    
    init(radius: CGFloat = .infinity, corners: UIRectCorner = .allCorners) {
        self.radius = radius
        self.corners = corners
    }
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// Dummy Views for Posts & Photos Section
struct PostsSectionView: View {
    var body: some View {
        VStack(spacing: 16) {
            ForEach(0..<3) { index in
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(hex: "F0F0F5"))
                    .frame(height: 120)
                    .overlay(Text("Post \(index + 1)").foregroundColor(.black))
            }
        }
    }
}

struct PhotosSectionView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(0..<9) { index in
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color(hex: "E0E0E0"))
                    .frame(height: 100)
                    .overlay(Text("Photo \(index + 1)").foregroundColor(.black))
            }
        }
    }
}
