//
//  iOSclubApp.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 23/01/25.
//

import SwiftUI

@main
struct iOSclubApp: App {
    @StateObject private var coordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            coordinator.start()
        }
    }
}
