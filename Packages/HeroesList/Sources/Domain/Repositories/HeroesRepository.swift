//
//  HeroesRepository.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 24/05/2025.
//

import Foundation
import NetworkProvider

public protocol HeroesRepository {
    func fetchHeroes<T: Request>(request: T) async throws -> FetchHeroesResponse
}
