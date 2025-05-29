//
//  HeroDetailsRepositoryImpl.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 25/05/2025.
//

import Foundation
import NetworkProvider
import SharedModels

public class HeroDetailsRepositoryImpl: HeroDetailsRepository {
    private let api: HeroDetailsAPI

    public init(api: HeroDetailsAPI) {
        self.api = api
    }

    public func fetchHeroDetails<T: Request>(request: T) async throws -> CharacterDataModel {
        return try await api.fetchHeroDetails(request: request)
    }
}
