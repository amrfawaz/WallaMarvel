//
//  HeroDetailsRepository.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 25/05/2025.
//

import Foundation
import NetworkProvider
import SharedModels

public protocol HeroDetailsRepository {
    func fetchHeroDetails<T: Request>(request: T) async throws -> CharacterDataModel
}
