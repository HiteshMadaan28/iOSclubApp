//
//  ChatView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 16/04/25.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    
    @FocusState private var isInputFocused: Bool

    var body: some View {
        VStack {
            // Message List
            ScrollViewReader { scrollView in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 12) {
                        ForEach(viewModel.messages) { message in
                            HStack {
                                if message.isSentByUser {
                                    Spacer()
                                }
                                
                                VStack(alignment: message.isSentByUser ? .trailing : .leading) {
                                    if !message.isSentByUser {
                                        // User Avatar (Optional)
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.blue)
                                    }
                                    
                                    Text(message.text)
                                        .padding()
                                        .background(message.isSentByUser ? Color.blue : Color.gray.opacity(0.3))
                                        .cornerRadius(10)
                                        .foregroundColor(.white)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                
                                if !message.isSentByUser {
                                    Spacer()
                                }
                            }
                        }

                        // Typing Indicator (Optional)
                        if viewModel.isTyping {
                            HStack {
                                Spacer()
                                Text("Typing...")
                                    .italic()
                                    .foregroundColor(.gray)
                                    .padding(.trailing)
                            }
                        }
                    }
                    .padding()
                }
                .onChange(of: viewModel.messages.count) { _ in
                    withAnimation {
                        scrollView.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                    }
                }
            }

            // Input Area
            HStack {
                TextField("Type a message...", text: $viewModel.inputText)
                    .padding(10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .focused($isInputFocused)
                    .onChange(of: viewModel.inputText) { _ in
                        viewModel.isTyping = true
                    }
                
                Button(action: {
                    viewModel.sendMessage()
                    isInputFocused = false  // Dismiss the keyboard after sending
                }) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.blue)
                        .font(.title)
                }
                .padding()
                .disabled(viewModel.inputText.isEmpty)  // Disable button when text is empty
            }
            .padding([.leading, .trailing])
        }
        .navigationTitle("Chat")
        .background(Color(.systemGray6).edgesIgnoringSafeArea(.bottom))  // Background Color
    }
}

//struct ChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatView()
//            .preferredColorScheme(.light)
//    }
//}
