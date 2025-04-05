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
    @State private var timer: Timer?

    let images = ["courses", "connections", "jobs", "news"]
    let descriptions = [
        "Learn new skills and grow",
        "Build your network and connect",
        "Find career opportunities",
        "Stay updated with latest news"
    ]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                Text("iOS-Club")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
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
                .padding(.top, 40)
                
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
                .padding(.bottom, 15)
                
                VStack {
                    Text("By clicking Agree & Join or Continue, you agree to iOS club's ")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    +
                    Text("User Agreement, Privacy Policy")
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
                .padding(.horizontal)
                .padding([.leading, .trailing], 16)

                VStack(spacing: 15) {
                    Button(action: {}) {
                        Text("Agree and Join")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(28)
                    }
                    
                    SignInWithAppleButton(.signIn) { request in
                        request.requestedScopes = [.email, .fullName]
                    } onCompletion: { result in
                        switch result {
                        case .success(let auth):
                            switch auth.credential {
                            case let credential as ASAuthorizationAppleIDCredential:
                                
                                let appleID = credential.user
                                let email = credential.email ?? "No Email Provided" // Fallback if it's nil
                                let firstName = credential.fullName?.givenName ?? ""
                                let lastName = credential.fullName?.familyName ?? ""
                                
                                print("✅ Apple ID: \(appleID)")
                                print("📧 Email: \(email)")
                                print("👤 Name: \(firstName) \(lastName)")

                                if let identityTokenData = credential.identityToken,
                                   let identityTokenString = String(data: identityTokenData, encoding: .utf8) {
                                    
                                    // 🔥 Call Supabase Authentication
                                    viewModel.signInWithSupabase(
                                        identityToken: identityTokenString,
                                        appleID: appleID,
                                        email: email,
                                        firstName: firstName,
                                        lastName: lastName
                                    )
                                } else {
                                    print("❌ Failed to retrieve identity token")
                                }

                            default:
                                break
                            }
                        case .failure(let error):
                            print("❌ Apple Sign-In Failed: \(error.localizedDescription)")
                        }
                    }
                    .frame(height: 50)
                    .signInWithAppleButtonStyle(.white)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 28)
                            .stroke(Color.gray.opacity(0.6), lineWidth: 1)
                    )
                    
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
            .onAppear {
                startAutoScroll()
            }
            .onDisappear {
                stopAutoScroll()
            }
        }
    }
    
    // Timer-based auto-scroll function
    func startAutoScroll() {
        stopAutoScroll() // Ensure only one timer exists
        timer = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                currentIndex = (currentIndex + 1) % images.count
            }
        }
    }
    
    func stopAutoScroll() {
        timer?.invalidate()
        timer = nil
    }
}


struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
