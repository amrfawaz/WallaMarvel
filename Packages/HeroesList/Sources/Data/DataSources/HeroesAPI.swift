//
//  HeroesAPI.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 24/05/2025.
//

import Foundation
import NetworkProvider

public protocol MovieAPIProtocol {
    func fetchHeroes(request: Request) async throws -> FetchHeroesResponse
}

public class HeroesAPI: MovieAPIProtocol {
    private let networkProvider: NetworkProvider
    private let urlSession = URLSession.shared

    public init(networkProvider: NetworkProvider = NetworkProvider()) {
        self.networkProvider = networkProvider
    }

    public func fetchHeroes(request: Request) async throws -> FetchHeroesResponse {
        guard let url = request.request?.url else { throw NetworkError.invalidURL }

        print(url.absoluteString)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = request.params.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let request = request.request else { throw NetworkError.invalidRequest }

        do {
            return try await networkProvider.request(request: request, of: FetchHeroesResponse.self)
        } catch {
            throw error
        }
    }
}
