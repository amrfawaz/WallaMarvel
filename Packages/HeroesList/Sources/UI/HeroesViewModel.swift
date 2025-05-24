//
//  HeroesViewModel.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 24/05/2025.
//

import Foundation
import Combine

@MainActor
final public class HeroesViewModel: ObservableObject {
    @Published var heroes: [CharacterDataModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""

    public var pageTitle: String {
        "List of Heroes!"
    }

    private let heroesUseCase: HeroesUseCase

    public init(heroesUseCase: HeroesUseCase) {
        self.heroesUseCase = heroesUseCase
    }

}

extension HeroesViewModel {
    nonisolated func fetchHeroes() async {
        let currentlyLoading = await MainActor.run { isLoading }
        guard !currentlyLoading else { return }
        
        await MainActor.run { isLoading = true }

        do {
            
            let response = try await heroesUseCase.execute(request: FetchHeroesRequset())
            await MainActor.run {
                self.heroes.append(contentsOf: response.characters)
                self.isLoading = false
            }

        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }

        }
    }
}

// MARK: Mocks

#if DEBUG

extension HeroesViewModel {
    static var mockHeroesViewModel: HeroesViewModel {
        let viewModel = HeroesViewModel(heroesUseCase: MockHeroesUseCase(repository: HeroesRepositoryImpl(api: HeroesAPI())))
        viewModel.heroes = CharacterDataModel.mockedHeros
        return viewModel
    }
}

#endif
