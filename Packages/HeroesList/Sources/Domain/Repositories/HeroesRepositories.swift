//
//  HeroesRepositories.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 24/05/2025.
//

import Foundation

public protocol HeroesRepositories {
    func fetchHeroes<T: Request>(request: T) async throws -> FetchHeroesResponse
}
