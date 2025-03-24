//
//  LoginView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 24/03/25.
//

import SwiftUI
import _AuthenticationServices_SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome Back").font(.largeTitle).bold()
                
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                
                Button("Login") {
                    viewModel.login(email: email, password: password)
                }
                .buttonStyle(.borderedProminent)
                
                Text("Or").padding(.vertical)
                
                SignInWithAppleButton(.signIn, onRequest: { request in
                    request.requestedScopes = [.email, .fullName]
                }, onCompletion: { _ in
                    viewModel.handleAppleSignIn()
                })
                .frame(height: 45)
                .signInWithAppleButtonStyle(.black)
                .cornerRadius(8)
                
                Button(action: {
//                    viewModel.handleGoogleSignIn()
                }) {
                    HStack {
                        Image(systemName: "globe")
                        Text("Sign in with Google")
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                
                if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                }
                
                NavigationLink("Don't have an account? Sign Up", destination: SignupView(viewModel: viewModel))
                
                Spacer()
            }
            .padding()
            .navigationTitle("Login")
        }
    }
}

#Preview {
    LoginView()
}
