//
//  WebSocketManager.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 16/04/25.
//

import Foundation

class WebSocketManager: NSObject {
    private var webSocket: URLSessionWebSocketTask?
    private let websocketURL = URL(string: "wss://jgjldpbanbvqmjzcndit.supabase.co/realtime/v1/websocket?apikey=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpnamxkcGJhbmJ2cW1qemNuZGl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk0MTg3NjEsImV4cCI6MjA1NDk5NDc2MX0.tLZ_9mQUOxeZAPuSLPml3lR3CNsOm_yDkGmN2y9rSME&vsn=1.0.0")!

    private var session: URLSession!

    var onMessageReceived: ((String) -> Void)?

    override init() {
        super.init()
        session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
    }

    func connect() {
        webSocket = session.webSocketTask(with: websocketURL)
        webSocket?.resume()
        receive()
    }

    func send(message: String) {
        webSocket?.send(.string(message)) { error in
            if let error = error {
                print("Send error: \(error)")
            }
        }
    }

    private func receive() {
        webSocket?.receive { [weak self] result in
            switch result {
            case .failure(let error):
                print("Receive error: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    self?.onMessageReceived?(text)
                default:
                    break
                }
                self?.receive()
            }
        }
    }

    func disconnect() {
        webSocket?.cancel(with: .goingAway, reason: nil)
    }
}

extension WebSocketManager: URLSessionWebSocketDelegate {
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask,
                    didOpenWithProtocol protocol: String?) {
        print("WebSocket Connected")
    }

    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask,
                    didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("WebSocket Disconnected")
    }
}
