//
//  SerachBar.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 14/03/25.
//

import SwiftUI

struct SearchBar: View {
    // MARK: - Properties
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    var placeholder: String = "Search"
    
    var onSearch: (() -> Void)? = nil // Optional closure when search begins
    
    var body: some View {
        HStack {
            // Magnifying Glass Icon
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            // TextField
            TextField(placeholder, text: $text)
                .foregroundColor(.primary)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .focused($isFocused)
                .onSubmit {
                    onSearch?()
                }
            
            // Clear Button
            if !text.isEmpty {
                Button(action: {
                    withAnimation {
                        text = ""
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .transition(.opacity)
            }
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isFocused ? Color.blue : Color.clear, lineWidth: 1)
        )
        .padding(.horizontal)
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
}

#Preview {
    StatefulPreviewWrapper("") { text in
        SearchBar(text: text)
    }
}


struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State private var value: Value
    private let content: (Binding<Value>) -> Content

    init(_ initialValue: Value, @ViewBuilder content: @escaping (Binding<Value>) -> Content) {
        self._value = State(wrappedValue: initialValue)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}


