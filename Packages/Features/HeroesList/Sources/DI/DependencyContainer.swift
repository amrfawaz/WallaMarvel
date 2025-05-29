//
//  DependencyContainer.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 29/05/2025.
//

import Foundation
import SharedModels
import HeroDetails

@MainActor
public final class DependencyContainer {
    // Heroes dependencies
    public let heroesRepository: HeroesRepositoryImpl
    public let heroesUseCase: HeroesUseCase

    // Hero Details dependencies
    public let heroDetailsRepository: HeroDetailsRepositoryImpl
    public let heroDetailsUseCase: HeroDetailsUseCase

    public init() {
        // Initialize Heroes dependencies
        self.heroesRepository = HeroesRepositoryImpl(api: HeroesAPI())
        self.heroesUseCase = HeroesUseCase(repository: heroesRepository)
        
        // Initialize Hero Details dependencies
        self.heroDetailsRepository = HeroDetailsRepositoryImpl(api: HeroDetailsAPI())
        self.heroDetailsUseCase = HeroDetailsUseCase(repository: heroDetailsRepository)
    }

    public func makeHeroesViewModel() -> HeroesViewModel {
        HeroesViewModel(heroesUseCase: heroesUseCase)
    }

    public func makeHeroDetailsViewModel(heroId: Int) -> HeroDetailsViewModel {
        HeroDetailsViewModel(heroId: heroId, heroDetailsUseCase: heroDetailsUseCase)
    }
}
