//
//  LandingView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 25/03/25.
//

import SwiftUI
import AuthenticationServices

struct LandingView: View {
    
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
                    
//                    SignInWithAppleButton(.signIn) { request in
//                        request.requestedScopes = [.email, .fullName]
//                    } onCompletion: { result in
//                        switch result {
//                        case .success(let authResults):
//                            switch authResults.credential {
//                            case let appleIDCredential as ASAuthorizationAppleIDCredential:
//                                guard let token = appleIDCredential.identityToken,
//                                      let idTokenString = String(data: token, encoding: .utf8) else {
//                                    print("❌ Unable to fetch identity token")
//                                    return
//                                }
//
//                                let credential = OAuthProvider.credential(
//                                    withProviderID: "apple.com",
//                                    idToken: idTokenString,
//                                    rawNonce: nil // Optional: implement nonce if needed
//                                )
//
//                                Auth.auth().signIn(with: credential) { authResult, error in
//                                    if let error = error {
//                                        print("❌ Firebase Sign-In Failed: \(error.localizedDescription)")
//                                        return
//                                    }
//
//                                    if let user = authResult?.user {
//                                        print("✅ Firebase Sign-In Success")
//                                        print("👤 UID: \(user.uid)")
//                                        print("📧 Email: \(user.email ?? "No Email")")
//
//                                        // Optional: Save user info to Firestore
//                                        saveUserToFirestore(user: user, appleIDCredential: appleIDCredential)
//                                    }
//                                }
//
//                            default:
//                                break
//                            }
//
//                        case .failure(let error):
//                            print("❌ Apple Sign-In Failed: \(error.localizedDescription)")
//                        }
//                    }

                    
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
