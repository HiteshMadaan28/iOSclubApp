//
//  ChatViewModel.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 16/04/25.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var inputText: String = ""

    private let webSocketManager = WebSocketManager()

    init() {
        webSocketManager.connect()
        webSocketManager.onMessageReceived = { [weak self] text in
            DispatchQueue.main.async {
                self?.messages.append(Message(text: text, isSentByUser: false))
            }
        }
    }

    func sendMessage() {
        guard !inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        let message = inputText
        messages.append(Message(text: message, isSentByUser: true))
        webSocketManager.send(message: message)
        inputText = ""
    }

    deinit {
        webSocketManager.disconnect()
    }
}
