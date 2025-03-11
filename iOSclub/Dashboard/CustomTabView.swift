//
//  CustomTabView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 26/01/25.
//

import SwiftUI

struct CustomTabView: View {
    @EnvironmentObject var coordinator: AppCoordinator

    var body: some View {
        ZStack {
            // MARK: - Main Views
            Group {
                switch coordinator.selectedTab {
                case .home:
                    DashboardView()
                case .jobs:
                    JobsView()
                case .news:
                    NewsContentView()
                case .socialMedia:
                    SocialMediaHomeContentView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)


            // MARK: - Custom Floating Tab Bar
            VStack {
                Spacer()
                FloatingTabBar(
                    selectedTab: coordinator.selectedTab,
                    tabs: AppCoordinator.Tab.allCases,
                    onTabSelected: { tab in
                        withAnimation(.spring()) {
                            coordinator.selectTab(tab)
                        }
                    }
                )
                .padding(.bottom, 20)
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct FloatingTabBar: View {
    var selectedTab: AppCoordinator.Tab
    var tabs: [AppCoordinator.Tab]
    var onTabSelected: (AppCoordinator.Tab) -> Void

    var body: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                TabBarItemView(
                    tab: tab,
                    isSelected: selectedTab == tab,
                    onTap: {
                        onTabSelected(tab)
                    }
                )
            }
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 24)
        .background(
            Color.white
                .cornerRadius(24)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal, 32)
    }
}

struct TabBarItemView: View {
    let tab: AppCoordinator.Tab
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: {
            onTap()
        }) {
            VStack(spacing: 6) {
                Image(systemName: isSelected ? tab.selectedIcon : tab.rawValue)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(isSelected ? Color(hex: "#007AFF") : .gray)
                    .scaleEffect(isSelected ? 1.2 : 1.0)
                    .animation(.spring(response: 0.4, dampingFraction: 0.6), value: isSelected)

                Text(tab.title)
                    .font(.caption)
                    .foregroundColor(isSelected ? Color(hex: "#007AFF") : .gray)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

// MARK: - Example Content Views

struct JobsView: View {
    var body: some View {
        Text("Jobs")
            .font(.largeTitle)
            .fontWeight(.bold)
    }
}

// MARK: - Preview

#Preview {
    CustomTabView()
        .environmentObject(AppCoordinator())
}
