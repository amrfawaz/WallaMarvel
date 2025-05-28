//
//  DependencyContainer.swift
//  WallaMarvel
//
//  Created by Amr Abd-Elhakim on 29/05/2025.
//

import Foundation
import SharedModels
import HeroesList
import HeroDetails

@MainActor
public final class DependencyContainer {
    // Lazy initialization to avoid creating unless needed
    public lazy var heroesRepository = HeroesRepositoryImpl(api: HeroesAPI())
    public lazy var heroesUseCase = HeroesUseCase(repository: heroesRepository)
    
    public lazy var heroDetailsRepository = HeroDetailsRepositoryImpl(api: HeroDetailsAPI())
    public lazy var heroDetailsUseCase = HeroDetailsUseCase(repository: heroDetailsRepository)
    
    public init() {}
    
    public func makeHeroesViewModel() -> HeroesViewModel {
        HeroesViewModel(heroesUseCase: heroesUseCase)
    }
    
    public func makeHeroDetailsViewModel(heroId: Int) -> HeroDetailsViewModel {
        HeroDetailsViewModel(heroId: heroId, heroDetailsUseCase: heroDetailsUseCase)
    }
}
