//
//  Coordinator.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 10/03/25.
//

import SwiftUI
import Combine

protocol Coordinator: ObservableObject {
    associatedtype ContentView: View
    @ViewBuilder func start() -> ContentView
}
