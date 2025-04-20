//
//  RootView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 20/04/25.
//

import SwiftUI

struct RootView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some View {
        Group {
            if authViewModel.isSignedIn {
                let _ = print("\(authViewModel.username)")
                coordinator.start()
            } else {
                LandingView()
            }
        }
    }
}

#Preview {
    RootView()
}
