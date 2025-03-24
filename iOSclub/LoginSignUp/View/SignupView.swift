//
//  SignupView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 24/03/25.
//

import SwiftUI

struct SignupView: View {
    @ObservedObject var viewModel: AuthViewModel
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account").font(.largeTitle).bold()
            
            TextField("Name", text: $name)
                .textFieldStyle(.roundedBorder)
            
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            Button("Sign Up") {
                viewModel.signup(email: email, password: password, name: name)
            }
            .buttonStyle(.borderedProminent)
            
            if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Sign Up")
    }
}



