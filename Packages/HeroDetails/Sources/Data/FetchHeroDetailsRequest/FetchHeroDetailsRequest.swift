//
//  FetchHeroDetailsRequest.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 25/05/2025.
//

import Foundation
import EnvironmentVariables
import NetworkProvider
import Helpers

public struct FetchHeroesRequset: Request {
    let id: Int

    public var endPoint: String {
        return EnvironmentVariables.Endpoints.getHeroDetails(id: id).path
    }

    public var params: [String: String] {
        return [
            "apikey": publicKey,
            "ts": ts,
            "hash": hash,
        ]
    }

    public init(id: Int) {
        self.id = id
    }
}
