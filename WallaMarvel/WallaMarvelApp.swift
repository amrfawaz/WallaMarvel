//
//  WallaMarvelApp.swift
//  WallaMarvel
//
//  Created by Amr Abd-Elhakim on 24/05/2025.
//

import SwiftUI
import SharedModels

@main
struct WallaMarvelApp: App {
    @MainActor
    private let dependencies = DependencyContainer()

    var body: some Scene {
        WindowGroup {
            NavigationContainer(
                coordinator: AppCoordinator(dependencies: dependencies)
            )
        }
    }
}
