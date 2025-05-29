//
//  HeroesContainer.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 29/05/2025.
//

import SwiftUI
import SharedModels

public struct HeroesContainer: View {
    private let dependencies: DependencyContainer
    
    public init(dependencies: DependencyContainer? = nil) {
        self.dependencies = dependencies ?? DependencyContainer()
    }
    
    public var body: some View {
        NavigationContainer(
            coordinator: HeroesCoordinator(dependencies: dependencies)
        )
    }
}
