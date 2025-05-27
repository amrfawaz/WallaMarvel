//
//  EnvironmentVariables.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 23/05/2025.
//

import Foundation

public enum EnvironmentVariables: String {
    case baseUrl = "https://gateway.marvel.com:443"
    case version = "/v1"
    case accept = "application/json"

    // Endpoints
    public enum Endpoints {
        case getHeroes
        case getHeroDetails(id: Int)
        
        public var path: String {
            switch self {
            case .getHeroes:
                return "/public/characters"
            case .getHeroDetails(let id):
                return "/public/characters/\(id)"
            }
        }
    }
}
