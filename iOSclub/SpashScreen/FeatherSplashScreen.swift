//
//  FeatherSplashScreen.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 24/01/25.
//

import SwiftUI

struct SplashScreen: View {
    @StateObject private var coordinator = AppCoordinator()
    @StateObject private var authViewModel = AuthViewModel.shared // Use shared instance
    @State private var isActive = false // For navigation to the main screen
    @State private var gradientFill: CGFloat = 0 // Gradient progress
    
    
    var body: some View {
        if isActive {
            if authViewModel.isSignedIn {
               let _ =  print("User is signed in: \(authViewModel.currentUser?.username ?? "Unknown")") // Debug print
                coordinator.start()
                    .environmentObject(authViewModel)
            } else {
               let _ = print("User is not signed in.") // Debug print
                LandingView()
                    .environmentObject(authViewModel)
            }
        } else {
            ZStack {
                Color.white.ignoresSafeArea() // Background color
                
                // App Logo with gradient fill animation
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200) // Adjust size as needed
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.green]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .frame(width: 200, height: 200)
                        .mask(
                            Image("AppLogo")
                                .resizable()
                                .scaledToFit()
                        )
                        .opacity(gradientFill)
                    )
                    .onAppear {
                        withAnimation(.easeInOut(duration: 2.5)) {
                            gradientFill = 1.0 // Gradually fill the logo
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            withAnimation {
                                isActive = true // Navigate to the main screen
                            }
                        }
                    }
            }
        }
    }
}

struct MainView: View {
    var body: some View {
        Text("Welcome to iOSclub!")
            .font(.largeTitle)
            .bold()
    }
}

struct FeatherSplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
        
    }
}
