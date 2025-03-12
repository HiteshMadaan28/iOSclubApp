//
//  SocialMediaProfileView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 11/03/25.
//

import SwiftUI

struct SocialMediaProfileView: View {
    
    @State private var selectedTab: Tab = .posts
    
    enum Tab {
        case posts
        case photos
    }
    
    var body: some View {
        
        // Profile Header View (keeping as-is)
        HStack(spacing: 0) {
            Image("Chevron left")
                .frame(width: 24, height: 24)
                .padding(.leading, 14)
            
            Spacer()
            
            Text("Katie Lee")
                .foregroundStyle(Color(hex: "323842"))
                .font(.custom("Inter", size: 18).bold())
            
            Spacer()
            
            Image("Search")
                .padding(.trailing, 14)
        }
        
        ScrollView {
            VStack(spacing: 0) {
                
                // Banner and Avatar (keeping as-is)
                ZStack {
                    Image("DemoBanner")
                        .resizable()
                        .cornerRadius(16, corners: [.topLeft, .topRight])
                        .frame(height: 150)
                        .padding([.leading, .trailing], 24)
                    
                    VStack(spacing: 0) {
                        Image("Avatar")
                            .frame(width: 160, height: 160)
                            .cornerRadius(100)
                    }
                    .offset(y: 80)
                }
                .padding(.top, 12)
                .padding(.bottom, 80)
                
                // User Info
                Text("Jena")
                    .font(.custom("Archivo", size: 20).bold())
                    .padding(.top, 18)
                
                Text("Photographer, travelholic, food love and iOS Dev")
                    .font(.custom("Inter", size: 16))
                    .foregroundStyle(Color(hex: "9095A0"))
                    .padding(.top, 10)
                    .padding([.leading, .trailing], 70)
                    .multilineTextAlignment(.center)
                
                // Follow & Message Buttons (keeping as-is)
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
                    
                    HStack(spacing: 0) {
                        Spacer()
                        
                        Image("Chat circle dots")
                        Text("Message")
                            .font(.custom("Inter", size: 14))
                            .foregroundStyle(Color.white)
                            .padding(.leading, 6)
                        
                        Spacer()
                    }
                    .foregroundStyle(Color.white)
                    .frame(height: 36)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color(hex: "636AE8"))
                    )
                    .padding(.leading, 10)
                    
                    HStack(spacing: 0) {
                        Image("More vert")
                            .padding(10)
                    }
                    .foregroundStyle(Color.white)
                    .frame(height: 36)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color(hex: "9095A0"), lineWidth: 1)
                    )
                    .padding(.leading, 10)
                }
                .padding(.top, 18)
                .padding([.leading, .trailing], 24)
                
                // Divider Above Tabs
                Divider()
                    .padding(.top, 25)
                
                // Tabs Section
                HStack(spacing: 0) {
                    Spacer()
                    
                    Button(action: {
                        selectedTab = .posts
                    }) {
                        HStack(spacing: 0) {
                            Image("PostIcon")
                                .renderingMode(.template)
                                .foregroundStyle(selectedTab == .posts ? Color(hex: "7F55E0") : Color(hex: "424955"))
                            
                            Text("Posts")
                                .foregroundStyle(selectedTab == .posts ? Color(hex: "7F55E0") : Color(hex: "424955"))
                                .padding(.leading, 10.25)
                        }
                        .padding(.leading, 14.25)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        selectedTab = .photos
                    }) {
                        HStack(spacing: 0) {
                            Image("ImageIcon")
                                .renderingMode(.template)
                                .foregroundStyle(selectedTab == .photos ? Color(hex: "7F55E0") : Color(hex: "424955"))
                            
                            Text("Photos")
                                .foregroundStyle(selectedTab == .photos ? Color(hex: "7F55E0") : Color(hex: "424955"))
                                .padding(.leading, 10.25)
                        }
                        .padding(.leading, 14.25)
                    }
                    
                    Spacer()
                }
                .frame(height: 56)
                
                Divider()
                
                // Content for Tabs
                VStack {
                    if selectedTab == .posts {
                        PostsSectionView()
                    } else if selectedTab == .photos {
                        PhotosSectionView()
                    }
                }
                .padding(.top, 20)
                .padding([.leading, .trailing], 24)
                
            }
        }
        .scrollIndicators(.hidden)
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
