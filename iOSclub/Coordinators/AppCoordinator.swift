//
//  AppCoordinator.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 10/03/25.
//

// Coordinators/AppCoordinator.swift

import SwiftUI

final class AppCoordinator: Coordinator, ObservableObject {
    @Published var selectedTab: Tab = .home

    enum Tab: String, CaseIterable, Identifiable {
        case home, courses, news, jobs

        var id: String { rawValue }

        var title: String {
            switch self {
            case .home: return "Home"
            case .courses: return "Courses"
            case .news: return "News"
            case .jobs: return "Jobs"
            }
        }

        var icon: String {
            switch self {
            case .home: return "house"
            case .courses: return "folder"
            case .news: return "newspaper"
            case .jobs: return "latch.2.case"
            }
        }

        var selectedIcon: String {
            switch self {
            case .home: return "house.fill"
            case .courses: return "folder.fill"
            case .news: return "newspaper.fill"
            case .jobs: return "latch.2.case.fill"
            }
        }
    }

    func start() -> some View {
        CustomTabView().environmentObject(self)
    }

    func selectTab(_ tab: Tab) {
        selectedTab = tab
    }
}
