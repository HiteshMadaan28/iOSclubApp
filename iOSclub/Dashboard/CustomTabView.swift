//
//  CustomTabView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 26/01/25.
//

import SwiftUI

struct CustomTabView: View {
    @State private var selectedTab: Tab = .home

    enum Tab {
        case home, connections, jobs, news
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            // Home Tab
            DashboardView()
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == .home ? "house.fill" : "house")
                        Text("Home")
                    }
                }
                .tag(Tab.home)

            // Connections Tab
            ConnectionsView()
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == .connections ? "person.3.fill" : "person.3")
                        Text("Connections")
                    }
                }
                .tag(Tab.connections)

            // Jobs Tab
//            JobsView()
            CoursesView()
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == .jobs ? "briefcase.fill" : "briefcase")
                        Text("Jobs")
                    }
                }
                .tag(Tab.jobs)

            // News Tab
            NewsView()
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == .news ? "newspaper.fill" : "newspaper")
                        Text("News")
                    }
                }
                .tag(Tab.news)
        }
        .accentColor(Color(hex: "#007AFF")) // Active tab color
    }
}

struct ConnectionsView: View {
    var body: some View {
        Text("Connections")
            .font(.largeTitle)
            .fontWeight(.bold)
    }
}

struct JobsView: View {
    var body: some View {
        Text("Jobs")
            .font(.largeTitle)
            .fontWeight(.bold)
    }
}

struct NewsView: View {
    var body: some View {
        Text("News")
            .font(.largeTitle)
            .fontWeight(.bold)
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
    }
}
