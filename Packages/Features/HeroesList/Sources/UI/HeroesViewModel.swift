//
//  HeroesViewModel.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 24/05/2025.
//

import Foundation
import Combine
import SharedModels

final public class HeroesViewModel: ObservableObject {
    @Published var heroes: [CharacterDataModel] = []
    @Published var filteredHeroes: [CharacterDataModel] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""

    private let heroesUseCase: HeroesUseCase

    private var currentPage = 0
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
    @MainActor
    func fetchHeroes() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            // Make the api call in the background thread by detaching the task
            let response = try await Task.detached { [heroesUseCase, currentPage] in
                return try await heroesUseCase.execute(request: FetchHeroesRequset(page: currentPage))
            }.value

            heroes.append(contentsOf: response.characters)
            currentPage = (response.offset / response.limit) + 1
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
