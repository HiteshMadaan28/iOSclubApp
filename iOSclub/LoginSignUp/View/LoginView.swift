//
//  LoginView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 24/03/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    @State private var showSignupSheet = false
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var coordinator = AppCoordinator()
    
    @ObservedObject private var authViewModel = AuthViewModel.shared

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("iOS-Club")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading, 20)

                Spacer()

                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 20))
                        .padding(.trailing, 20)
                        .foregroundColor(.black)
                }
            }
            .padding(.top, 20)
            
            Text("Welcome Back")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 10)
            
            TextField("Email", text: $email)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .keyboardType(.emailAddress)
                .padding(.top, 10)
            
            SecureField("Password", text: $password)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .padding(.top, 10)
            
            HStack {
                Spacer()
                NavigationLink("Forgot Password?", destination: Text("Forgot Password View"))
                    .font(.footnote)
                    .foregroundColor(.blue)
                    .padding(.top, 5)
                    .padding(.trailing, 20)
            }
            
            Button(action: {
                authViewModel.email = email
                authViewModel.password = password
                authViewModel.signIn()
            }) {
                Text("Login")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(28)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
            }

            if !authViewModel.errorMessage.isEmpty {
                Text(authViewModel.errorMessage)
                    .foregroundColor(.red)
                    .padding(.top, 5)
                    .padding(.horizontal, 20)
            }

            ZStack {
                Divider()
                Text("Or")
                    .padding([.leading, .trailing], 10)
                    .background(Color.white)
            }
            .padding(.horizontal, 20)
            
            Button("Don't have an account? Sign Up") {
                showSignupSheet.toggle()
            }
            .font(.footnote)
            .padding(.top, 10)
            .foregroundColor(.blue)
            .padding(.horizontal, 20)
            
            Spacer()
            
            // If authenticated, navigate to the RootView
            NavigationLink(destination: coordinator.start(), isActive: $authViewModel.isSignedIn) {
                EmptyView()
            }
        }
        .padding(.bottom, 30)
        .navigationTitle("")
        .navigationBarHidden(true)
        .sheet(isPresented: $showSignupSheet) {
            SignupView()
        }
        .onChange(of: authViewModel.isSignedIn) { isAuthenticated in
            if isAuthenticated {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

#Preview {
    LoginView()
}

