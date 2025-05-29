//
//  HeroDetailsUseCase.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 25/05/2025.
//

import Foundation
import NetworkProvider
import SharedModels

public class HeroDetailsUseCase: @unchecked Sendable {
    private let repository: HeroDetailsRepository

    public init(repository: HeroDetailsRepository) {
        self.repository = repository
    }

    func execute<T: Request>(request: T) async throws -> CharacterDataModel {
        return try await repository.fetchHeroDetails(request: request)
    }

}

// MARK: - Mocks

#if DEBUG
final class MockHeroDetailsUseCase: HeroDetailsUseCase, @unchecked Sendable {
    var responseData: Data?
    var responseError: NetworkError?

    override func execute<T>(request: T) async throws -> CharacterDataModel where T : Request {
        if let error = responseError {
            throw error
        }

        guard let data = responseData else {
            throw NetworkError.noData
        }

        do {
            let decodedResponse = try JSONDecoder().decode(CharacterDataModel.self, from: data)
            return decodedResponse
        } catch {
            throw NetworkError.decodingError
        }
    }
}
#endif
