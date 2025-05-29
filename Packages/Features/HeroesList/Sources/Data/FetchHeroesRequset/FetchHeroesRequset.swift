//
//  FetchHeroesRequset.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 23/05/2025.
//

import Foundation
import EnvironmentVariables
import NetworkProvider

public struct FetchHeroesRequset: Request {
    let page: Int

    public var endPoint: String {
        return EnvironmentVariables.Endpoints.getHeroes.path
    }

    public var params: [String: String] {
        return [
            "apikey": publicKey,
            "ts": ts,
            "hash": hash,
            "limit": "10",
            "offset": "\(page * 10)"
        ]
    }

    public init(page: Int) {
        self.page = page
    }
}
