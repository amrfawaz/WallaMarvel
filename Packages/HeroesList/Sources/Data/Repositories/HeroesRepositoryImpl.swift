//
//  HeroesRepositoryImpl.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 24/05/2025.
//

import Foundation
import NetworkProvider

public class HeroesRepositoryImpl: HeroesRepository {
    private let api: HeroesAPI

    public init(api: HeroesAPI) {
        self.api = api
    }

    public func fetchHeroes<T: Request>(request: T) async throws -> FetchHeroesResponse {
        return try await api.fetchHeroes(request: request)
    }
}
