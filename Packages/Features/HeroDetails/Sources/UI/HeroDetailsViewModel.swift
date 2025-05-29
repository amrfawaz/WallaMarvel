//
//  File.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 25/05/2025.
//

import Foundation
import Combine
import SharedModels

public final class HeroDetailsViewModel: ObservableObject {
    private enum Constant {
        static let imageSize = "/detail."
        static let comicsTitle = "Comics"
        static let seriesTitle = "Series"
        static let storiesTitle = "Stories"
    }

    @Published var hero: CharacterDataModel?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""

    private let heroId: Int
    private let heroDetailsUseCase: HeroDetailsUseCase

    public init(
        heroId: Int,
        heroDetailsUseCase: HeroDetailsUseCase
    ) {
        self.heroId = heroId
        self.heroDetailsUseCase = heroDetailsUseCase
    }

    var name: String {
        hero?.name ?? ""
    }

    var image: String {
        guard let path = hero?.thumbnail.path,
              let extention = hero?.thumbnail.extension
        else { return "" }

        return path + Constant.imageSize + extention
    }

    var description: String {
        hero?.description ?? ""
    }

    var comicsViewModel: HeroInfoListViewModel? {
        guard let list = hero?.comics.items.map({ $0.name }) else { return nil }

        return HeroInfoListViewModel(
            title: Constant.comicsTitle,
            list: list
        )
    }

    var seriesViewModel: HeroInfoListViewModel? {
        guard let list = hero?.series.items.map({ $0.name }) else { return nil }

        return HeroInfoListViewModel(
            title: Constant.seriesTitle,
            list: list
        )
    }

    var storiesViewModel: HeroInfoListViewModel? {
        guard let list = hero?.stories.items.map({ $0.name }) else { return nil }
        
        return HeroInfoListViewModel(
            title: Constant.storiesTitle,
            list: list
        )
    }
}

// MARK: - Fetch Hero Details

extension HeroDetailsViewModel {
    @MainActor
    func fetchHeroDetails() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            // Make the api call in the background thread by detaching the task
            hero = try await Task.detached { [heroDetailsUseCase, heroId] in
                return try await heroDetailsUseCase.execute(request: FetchHeroesRequset(id: heroId))
            }.value
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
