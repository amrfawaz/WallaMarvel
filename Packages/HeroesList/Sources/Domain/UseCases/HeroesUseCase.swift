//
//  HeroesUseCase.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 24/05/2025.
//

import Foundation
import NetworkProvider

public class HeroesUseCase: @unchecked Sendable {
    private let repository: HeroesRepository

    public init(repository: HeroesRepository) {
        self.repository = repository
    }

    func execute<T: Request>(request: T) async throws -> FetchHeroesResponse {
        return try await repository.fetchHeroes(request: request)
    }

}

// MARK: - Mocks

#if DEBUG
final class MockHeroesUseCase: HeroesUseCase, @unchecked Sendable {
    var responseData: Data?
    var responseError: NetworkError?

    override func execute<T>(request: T) async throws -> FetchHeroesResponse where T : Request {
        if let error = responseError {
            throw error
        }

        guard let data = responseData else {
            throw NetworkError.noData
        }

        do {
            let decodedResponse = try JSONDecoder().decode(FetchHeroesResponse.self, from: data)
            return decodedResponse
        } catch {
            throw NetworkError.decodingError
        }
    }
}
#endif
