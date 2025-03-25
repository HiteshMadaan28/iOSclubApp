//
//  LandingView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 25/03/25.
//

import SwiftUI
import AuthenticationServices

struct LandingView: View {
    
    @StateObject private var viewModel = AuthViewModel()
    
    @State private var currentIndex = 0
    let images = [
        "courses",
        "connections",
        "jobs",
        "news"
    ]

    let descriptions = [
        "Learn new skills and grow",
        "Build your network and connect",
        "Find career opportunities",
        "Stay updated with latest news"
    ]

    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                // App Name at Top Left
                Text("iOS-Club")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()

                
                // Carousel View
                TabView(selection: $currentIndex) {
                    ForEach(0..<images.count, id: \.self) { index in
                        VStack {
                            Image(images[index])
                                .resizable()
                                .cornerRadius(20)
                                .scaledToFit()
                               
                            
                            Text(descriptions[index])
                                .font(.headline)
                                .padding(.top, 10)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(maxHeight: 300)
                .onAppear {
                    startAutoScroll()
                }
                .padding(.top,40)
                
                // Circle Indicators
                HStack(spacing: 10) {
                    Spacer()
                    ForEach(0..<images.count, id: \.self) { index in
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundColor(currentIndex == index ? .black : .white)
                            .overlay(
                                Circle()
                                    .stroke(Color.black, lineWidth: 1)
                            )
                    }
                    Spacer()
                }
                .padding(.top, 15)
                .padding(.bottom,15)
                
                // Text with Links
                VStack{
                    Text("By clicking Agree & Join or Continue, you agree to iOS club's ")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    +
                    Text("User Agreement,Privacy Policy")
                        .font(.footnote)
                        .foregroundColor(.blue)
                    +
                    Text(" and ")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    +
                    Text("Cookie Policy.")
                        .font(.footnote)
                        .foregroundColor(.blue)
                }
                .padding([.horizontal,.vertical])
                .padding([.leading, .trailing],16)

                
                // Buttons
                VStack(spacing: 15) {
                    Button(action: {
                        // Navigate to Signup Page
                    }) {
                        Text("Agree and Join")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(28)
                    }
                    
                    SignInWithAppleButton(.signIn) { request in
                        request.requestedScopes = [.fullName, .email]
                    } onCompletion: { result in
                        viewModel.handleAppleSignIn()
                    }
                    .frame(height: 50) // Improved height for better alignment
                    .signInWithAppleButtonStyle(.white) // Use white style for better visual contrast
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 28)
                            .stroke(Color.gray.opacity(0.6), lineWidth: 1) // Optional border for a clean look
                    )
                    
                    // Navigation to LoginView when "Sign In" text is tapped
                    NavigationLink(destination: LoginView()) {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(.top, 10)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
    }
    
    func startAutoScroll() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(.easeInOut(duration: 0.5)) {
                currentIndex = (currentIndex + 1) % images.count
            }
            startAutoScroll()
        }
    }

}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
