//
//  HeroesCoordinator.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 29/05/2025.
//

import SwiftUI
import SharedModels
import HeroDetails

@MainActor
public final class HeroesCoordinator: Coordinator, HeroesNavigationProtocol {
    @Published public var navigationPath = NavigationPath()
    @Published public var presentedSheet: HeroesPage?
    @Published public var presentedFullScreenCover: HeroesPage?
    
    private let dependencies: DependencyContainer
    public let heroesViewModel: HeroesViewModel
    
    public init(dependencies: DependencyContainer) {
        self.dependencies = dependencies
        self.heroesViewModel = dependencies.makeHeroesViewModel()
    }
    
    public var startPage: HeroesPage {
        .heroesList
    }
}

// MARK: - Pages
extension HeroesCoordinator {
    public enum HeroesPage: Hashable, Identifiable {
        case heroesList
        case heroDetail(heroId: Int)
        
        public var id: String {
            switch self {
            case .heroesList: return "heroesList"
            case .heroDetail(let heroId): return "heroDetail_\(heroId)"
            }
        }
    }
}

// MARK: - HeroesNavigationProtocol Implementation
extension HeroesCoordinator {
    public func showHeroDetail(_ heroId: Int) {
        navigate(to: .heroDetail(heroId: heroId))
    }
}

// MARK: - View Factory
extension HeroesCoordinator {
    public func view(for page: HeroesPage) -> AnyView {
        switch page {
        case .heroesList:
            return AnyView(
                HeroesView(
                    viewModel: heroesViewModel,
                    navigator: self
                )
            )
            
        case .heroDetail(let heroId):
            return AnyView(
                HeroDetailsView(
                    viewModel: dependencies.makeHeroDetailsViewModel(heroId: heroId)
                )
            )
        }
    }
}
