//
//  DashboardView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 26/01/25.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Dashboard Header
                HStack {
                    Spacer()
                    Text("Dashboard")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color(hex: "#111517"))
                        .padding(.leading, 12)
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 24))
                            .foregroundColor(Color(hex: "#111517"))
                    }
                    .padding(.trailing, 16)
                }
                .padding(.vertical, 8)

                // Recommended Courses Section
                SectionView(title: "Recommended Courses") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            CourseCard(
                                imageURL: "https://cdn.usegalileo.ai/sdxl10/5ea1d6f3-eb8e-4692-9222-1d37253240cd.png",
                                title: "SwiftUI: Working with UI Controls"
                            )
                            CourseCard(
                                imageURL: "https://cdn.usegalileo.ai/sdxl10/88f1bcba-e504-433c-b271-4ef2b1829b71.png",
                                title: "iOS 15: App Store Connect updates"
                            )
                            CourseCard(
                                imageURL: "https://cdn.usegalileo.ai/sdxl10/14371d41-1f01-4ce0-a72d-0af487bffbbe.png",
                                title: "App Clips and the App Library"
                            )
                        }
                        .padding(.horizontal, 16)
                    }
                }

                // New Connections Section
                SectionView(title: "New Connections") {
                    VStack(spacing: 16) {
                        ConnectionRow(
                            imageURL: "https://cdn.usegalileo.ai/sdxl10/c1d3364e-ec97-406a-96c0-c3b705ddfef3.png",
                            name: "Jenny Lutz",
                            role: "Senior iOS Engineer at Google"
                        )
                        ConnectionRow(
                            imageURL: "https://cdn.usegalileo.ai/sdxl10/4e55c470-ea62-454d-80cd-564a68934a2a.png",
                            name: "Jack Smith",
                            role: "iOS Developer at Facebook"
                        )
                        ConnectionRow(
                            imageURL: "https://cdn.usegalileo.ai/sdxl10/d14edf49-7242-40b9-9e3e-f358e7d1297b.png",
                            name: "Sandra Li",
                            role: "Software Engineer at Apple"
                        )
                        
                    }
                    .padding(.horizontal, 16)
                }

                // Featured Jobs Section
                SectionView(title: "Featured Jobs") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            JobCard(
                                imageURL: "https://cdn.usegalileo.ai/sdxl10/d149eff1-1e5d-41b9-ba98-3943ef7ed9a0.png",
                                title: "iOS Engineer at Netflix"
                            )
                            JobCard(
                                imageURL: "https://cdn.usegalileo.ai/sdxl10/4e04625a-dcf1-4841-ba87-13109871c978.png",
                                title: "Apple - Senior Software Engineer, iOS"
                            )
                        }
                        .padding(.horizontal, 16)
                    }
                }

                // Latest News Section
                SectionView(title: "Latest News") {
                    NewsCard(
                        title: "WWDC 2022: What to expect",
                        author: "By Alex Webb · 1d ago"
                    )
                    .padding(.horizontal, 16)
                }
                
            }
            .padding(.vertical, 16)
        }
        .scrollIndicators(.hidden)
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

// Reusable Components

struct SectionView<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(Color(hex: "#111517"))
                .padding(.horizontal, 16)
            content
        }
    }
}

struct CourseCard: View {
    let imageURL: String
    let title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.2)
            }
            .frame(height: 150)
            .cornerRadius(12)
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color(hex: "#111517"))
                .lineLimit(2)
        }
        .frame(width: 200)
    }
}

struct ConnectionRow: View {
    let imageURL: String
    let name: String
    let role: String

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.2)
            }
            .frame(width: 56, height: 56)
            .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color(hex: "#111517"))
                Text(role)
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "#647987"))
            }
            
            Spacer()
        }
    }
}

struct JobCard: View {
    let imageURL: String
    let title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.2)
            }
            .frame(width: 150, height: 150)
            .cornerRadius(12)
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color(hex: "#111517"))
                .lineLimit(2)
        }
        .frame(width: 150)
    }
}

struct NewsCard: View {
    let title: String
    let author: String

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color(hex: "#111517"))
                Text(author)
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "#647987"))
            }
            Spacer()
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        
    }
}

// Hex Color Support
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var int: UInt64 = 0
        scanner.scanHexInt64(&int)
        let r, g, b: Double
        r = Double((int >> 16) & 0xFF) / 255.0
        g = Double((int >> 8) & 0xFF) / 255.0
        b = Double(int & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
