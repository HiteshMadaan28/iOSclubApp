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
            // Main Views
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


            // Custom Floating Tab Bar
            VStack {
                Spacer()
                HStack {
                    ForEach(AppCoordinator.Tab.allCases, id: \.self) { tab in
                        Button(action: {
                            coordinator.selectTab(tab)
                        }) {
                            VStack(spacing: 6) {
                                Image(systemName: coordinator.selectedTab == tab ? tab.selectedIcon : tab.rawValue)
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(coordinator.selectedTab == tab ? Color(hex: "#007AFF") : .gray)

                                Text(tab.title)
                                    .font(.caption)
                                    .foregroundColor(coordinator.selectedTab == tab ? Color(hex: "#007AFF") : .gray)
                            }
                            .frame(maxWidth: .infinity)
                        }
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
                .padding(.bottom, 20)
            }
        }
    }
}


struct JobsView: View {
    var body: some View {
        Text("Jobs")
            .font(.largeTitle)
            .fontWeight(.bold)
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
    }
}
