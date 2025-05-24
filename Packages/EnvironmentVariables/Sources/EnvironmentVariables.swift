//
//  EnvironmentVariables.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 23/05/2025.
//

import Foundation

public enum EnvironmentVariables: String {
    case privateKey = "188f9a5aa76846d907c41cbea6506e4cc455293f"
    case publicKey = "d575c26d5c746f623518e753921ac847"
    case baseUrl = "https://gateway.marvel.com:443"
    case version = "/v1"
    case accept = "application/json"

    // Endpoints
    public enum Endpoints: String {
        case getHeroes = "/public/characters"
    }
}

