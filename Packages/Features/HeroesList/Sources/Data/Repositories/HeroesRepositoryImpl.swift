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


// MARK: - Mocks

#if DEBUG
final class MockHeroesRepository: HeroesRepository {
    var result: Result<FetchHeroesResponse, Error>?
    
    func fetchHeroes<T>(request: T) async throws -> FetchHeroesResponse where T : Request {
        print("Mock fetchHeroes called with request: \(request)")
        switch result {
        case .success(let response)?:
            return response
        case .failure(let error)?:
            throw error
        case .none:
            fatalError("Mock result not set")
        }
    }
}
#endif
