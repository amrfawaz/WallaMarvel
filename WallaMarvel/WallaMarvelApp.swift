//
//  WallaMarvelApp.swift
//  WallaMarvel
//
//  Created by Amr Abd-Elhakim on 24/05/2025.
//

import SwiftUI
import HeroesList

@main
struct WallaMarvelApp: App {
    var body: some Scene {
        WindowGroup {
            let repository = HeroesRepositoryImpl(api: HeroesAPI())
            let usecase = HeroesUseCase(repository: repository)
            let viewModel = HeroesViewModel(heroesUseCase: usecase)
            
            HeroesView(viewModel: viewModel)
        }
    }
}
