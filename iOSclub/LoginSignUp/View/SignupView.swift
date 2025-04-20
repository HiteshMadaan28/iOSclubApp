//
//  SignupView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 20/04/25.
//
import SwiftUI

struct SignupView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var authViewModel = AuthViewModel.shared
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Sign Up")
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
            
            TextField("Username", text: $authViewModel.username)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal, 20)
            
            TextField("Email", text: $authViewModel.email)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal, 20)
            
            SecureField("Password", text: $authViewModel.password)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal, 20)
            
            Button(action: {
                authViewModel.signUp()
            }) {
                Text("Create Account")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(28)
                    .padding(.horizontal, 20)
            }
            .padding(.top, 10)
            
            if !authViewModel.errorMessage.isEmpty {
                Text(authViewModel.errorMessage)
                    .foregroundColor(.red)
                    .padding(.top, 5)
                    .padding(.horizontal, 20)
            }
            
            Spacer()
        }
        .padding(.bottom, 30)
        .navigationTitle("")
        .navigationBarHidden(true)
        .onChange(of: authViewModel.isSignedIn) { isSignedIn in
            if isSignedIn {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

#Preview {
    SignupView()
}
