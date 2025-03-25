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
    
    // State variable to control the sheet presentation
    @State private var showSignupSheet = false
    
    // Adding Environment variable for managing navigation stack
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                // App Name on the left
                Text("iOS-Club")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading, 20)
                
                Spacer()
                
                // Cross Icon on the right to go back to LandingPage
                Button(action: {
                    // Action to go back to the LandingPage
                    self.presentationMode.wrappedValue.dismiss() // This will pop the current view
                }) {
                    Image(systemName: "xmark")
                        .font(.custom("", size: 20))
                        .padding(.trailing, 20)
                        .foregroundColor(.black)
                }
            }
            .padding(.top, 20)
            
            // Login Heading
            Text("Welcome Back")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 10)
            
            // Email TextField with improved UI
            TextField("Email", text: $email)
                .textFieldStyle(PlainTextFieldStyle()) // Custom text field style
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .keyboardType(.emailAddress)
                .padding(.top, 10)
            
            // Password SecureField with improved UI
            SecureField("Password", text: $password)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .padding(.top, 10)
            
            // Forgot Password link
            HStack {
                Spacer()
                NavigationLink("Forgot Password?", destination: Text("Forgot Password View")) // Replace with your Forgot Password View
                    .font(.footnote)
                    .foregroundColor(.blue)
                    .padding(.top, 5)
                    .padding(.trailing, 20)
            }
            
            // Login Button with improved UI
            Button(action: {
                viewModel.login(email: email, password: password)
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
            
            // Or Text
            ZStack{
                Divider()
                
                Text("Or")
                    .padding([.leading, .trailing], 10)
                    .background(Color.white)
            }
            .padding(.horizontal, 20)
            
            // Sign In with Apple Button with improved UI
            SignInWithAppleButton(.signIn, onRequest: { request in
                request.requestedScopes = [.email, .fullName]
            }, onCompletion: { _ in
                viewModel.handleAppleSignIn()
            })
            .frame(height: 50) // Improved height for better alignment
            .signInWithAppleButtonStyle(.white) // Use white style for better visual contrast
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 28)
                    .stroke(Color.gray.opacity(0.6), lineWidth: 1) // Optional border for a clean look
            )
            .padding(.horizontal, 20)
            
            // Error message if present
            if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red)
                    .padding(.top, 5)
                    .padding(.horizontal, 20)
            }
            
            // Sign Up Link to show the SignupView as a sheet
            Button("Don't have an account? Sign Up") {
                showSignupSheet.toggle() // Toggle the sheet presentation
            }
            .font(.footnote)
            .padding(.top, 10)
            .foregroundColor(.blue)
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .padding(.bottom, 30)
        .navigationTitle("") // Hide default navigation title
        .navigationBarHidden(true)  // Hide the navigation bar
        .sheet(isPresented: $showSignupSheet) {
            SignupView(viewModel: viewModel) // Show the SignupView in the sheet
        }
    }
}

#Preview {
    LoginView()
}
