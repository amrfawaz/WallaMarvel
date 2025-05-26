//
//  HeroDetailsAPI.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 25/05/2025.
//

import Foundation
import NetworkProvider
import SharedModels

public protocol HeroDetailsAPIProtocol {
    func fetchHeroDetails(request: Request) async throws -> CharacterDataModel
}

public class HeroDetailsAPI: HeroDetailsAPIProtocol {
    private let networkProvider: NetworkProvider
    private let urlSession = URLSession.shared

    public init(networkProvider: NetworkProvider = NetworkProvider()) {
        self.networkProvider = networkProvider
    }

    public func fetchHeroDetails(request: Request) async throws -> CharacterDataModel {
        guard let url = request.request?.url else { throw NetworkError.invalidURL }

        print(url.absoluteString)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = request.params.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let request = request.request else { throw NetworkError.invalidRequest }

        do {
            let response = try await networkProvider.request(
                request: request,
                of: FetchHeroDetailsResponse.self
            )
            guard let hero = response.characters.first else { throw NetworkError.noData }
            return hero
        } catch {
            throw error
        }
    }
}
