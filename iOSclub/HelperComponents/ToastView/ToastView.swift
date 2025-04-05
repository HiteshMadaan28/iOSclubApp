//
//  ToastView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 05/04/25.
//

import SwiftUI

struct ToastView: View {
    var message: String

    var body: some View {
        Text(message)
            .font(.headline)
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.black.opacity(0.85))
            .cornerRadius(10)
            .padding(.top, 50)
            .padding(.horizontal)
    }
}

#Preview {
    ToastView(message: "Hello")
}
