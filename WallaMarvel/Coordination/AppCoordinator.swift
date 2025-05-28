//
//  AppCoordinator.swift
//  WallaMarvel
//
//  Created by Amr Abd-Elhakim on 29/05/2025.
//

import SwiftUI
import SharedModels
import HeroesList
import HeroDetails

@MainActor
public final class AppCoordinator: Coordinator, HeroesNavigationProtocol {
    @Published public var navigationPath = NavigationPath()
    @Published public var presentedSheet: AppPage?
    @Published public var presentedFullScreenCover: AppPage?
    
    private let dependencies: DependencyContainer
    public let heroesViewModel: HeroesViewModel

    public init(dependencies: DependencyContainer) {
        self.dependencies = dependencies
        self.heroesViewModel = dependencies.makeHeroesViewModel()
    }
    
    public var startPage: AppPage {
        .heroesList
    }
}

// MARK: - App-Level Pages
extension AppCoordinator {
    public enum AppPage: Hashable, Identifiable {
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

// MARK: - HeroNavigationProtocol Implementation

@MainActor
extension AppCoordinator {
    public func showHeroDetail(_ heroId: Int) {
        navigate(to: .heroDetail(heroId: heroId))
    }
}

// MARK: - View Factory
extension AppCoordinator {
    public func view(for page: AppPage) -> AnyView {
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
