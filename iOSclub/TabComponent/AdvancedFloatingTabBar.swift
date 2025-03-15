//
//  AdvancedFloatingTabBar.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 15/03/25.
//

import SwiftUI

struct AdvancedFloatingTabBar: View {
    @Binding var selectedTab: TabItem
    @State private var previousTab: TabItem = .home

    var tabs: [TabItem]
    
    var onTabSelected: ((TabItem) -> Void)? = nil
    var onTabDeselected: ((TabItem) -> Void)? = nil
    var centerButtonAction: (() -> Void)? = nil
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) { tab in
                    if tab == .centerAction {
                        centerButton
                    } else {
                        tabButton(for: tab)
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 32)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 4)
            )
            .padding(.horizontal, 16)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private func tabButton(for tab: TabItem) -> some View {
        Button(action: {
            if selectedTab != tab {
                previousTab = selectedTab
                selectedTab = tab
                
                onTabDeselected?(previousTab)
                onTabSelected?(tab)
            }
        }) {
            VStack(spacing: 6) {
                Image(systemName: selectedTab == tab ? tab.selectedIconName : tab.iconName)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(selectedTab == tab ? Color.blue : Color.gray)
                    .scaleEffect(selectedTab == tab ? 1.2 : 1.0)
                    .animation(.easeInOut, value: selectedTab)
                
                Text(tab.title)
                    .font(.caption2)
                    .foregroundColor(selectedTab == tab ? Color.blue : Color.gray)
            }
            .frame(maxWidth: .infinity)
        }
        .disabled(selectedTab == tab)
    }
    
    private var centerButton: some View {
        Button(action: {
            centerButtonAction?()
        }) {
            ZStack {
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]),
                                         startPoint: .topLeading,
                                         endPoint: .bottomTrailing))
                    .frame(width: 64, height: 64)
                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
                
                Image(systemName: "plus")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
            }
            .offset(y: -32)
        }
    }
}

struct TabItem: Hashable {
    var iconName: String
    var selectedIconName: String
    var title: String
    
    static let home = TabItem(iconName: "house", selectedIconName: "house.fill", title: "Home")
    static let courses = TabItem(iconName: "book", selectedIconName: "book.fill", title: "Courses")
    static let news = TabItem(iconName: "newspaper", selectedIconName: "newspaper.fill", title: "News")
    static let profile = TabItem(iconName: "person", selectedIconName: "person.fill", title: "Profile")
    static let centerAction = TabItem(iconName: "plus", selectedIconName: "plus", title: "")
}

#Preview {
    VStack {
        Spacer()
        AdvancedFloatingTabBar(
            selectedTab: .constant(.home),
            tabs: [.home, .courses, .centerAction, .news, .profile],
            onTabSelected: { tab in
                print("Selected: \(tab.title)")
            },
            onTabDeselected: { tab in
                print("Deselected: \(tab.title)")
            },
            centerButtonAction: {
                print("Center button tapped!")
            }
        )
    }
}

