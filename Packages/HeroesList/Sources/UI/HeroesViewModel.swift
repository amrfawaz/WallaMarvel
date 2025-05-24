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
    @Published var filteredHeroes: [CharacterDataModel] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""

    private let heroesUseCase: HeroesUseCase
    private var cancellables = Set<AnyCancellable>()

    public init(heroesUseCase: HeroesUseCase) {
        self.heroesUseCase = heroesUseCase
        setupObservables()
    }

    private func setupObservables() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] searchText in
                self?.filterHeroes(with: searchText)
            }
            .store(in: &cancellables)
    }
}

// MARK: - Fetch Heroes

extension HeroesViewModel {
    func fetchHeroes() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await heroesUseCase.execute(request: FetchHeroesRequset())
            heroes = response.characters
            filterHeroes(with: searchText) // Apply current search after fetching
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

// MARK: - Filter
extension HeroesViewModel {
    private func filterHeroes(with searchText: String) {
        if searchText.isEmpty {
            filteredHeroes = heroes
        } else {
            filteredHeroes = heroes.filter { hero in
                hero.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    func clearSearch() {
        searchText = ""
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
