//
//  AppCoordinator.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 10/03/25.
//

import SwiftUI
import Combine

final class AppCoordinator: Coordinator, ObservableObject {
    
    // MARK: - Published Properties
    @Published var selectedTab: Tab = .home
    
    // MARK: - Tab Enum (same as in CustomTabView)
    enum Tab: String, CaseIterable {
        case home = "house"
        case courses = "folder"
        case news = "newspaper"
        case socialMedia = "person.3"
        
        var title: String {
            switch self {
            case .home: return "Home"
            case .courses: return "Courses"
            case .news: return "News"
            case .socialMedia: return "Connect"
            }
        }
        
        var selectedIcon: String {
            switch self {
            case .home: return "house.fill"
            case .courses: return "folder.fill"
            case .news: return "newspaper.fill"
            case .socialMedia: return "person.3.fill"
            }
        }
    }
    
    // MARK: - Start Navigation
    func start() -> some View {
        CustomTabView()
            .environmentObject(self)
    }
    
    // MARK: - Navigation Actions
    func selectTab(_ tab: Tab) {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.75, blendDuration: 0.5)) {
            selectedTab = tab
        }
    }
}
