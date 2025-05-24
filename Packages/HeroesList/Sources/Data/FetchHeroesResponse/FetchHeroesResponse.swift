//
//  FetchHeroesResponse.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 23/05/2025.
//

import Foundation

public struct FetchHeroesResponse: Decodable, Sendable {
    let count: Int
    let limit: Int
    let offset: Int
    let characters: [CharacterDataModel]
    
    enum CodingKeys: String, CodingKey {
        case data
        case count, limit, offset, characters = "results"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        self.count = try data.decode(Int.self, forKey: .count)
        self.limit = try data.decode(Int.self, forKey: .limit)
        self.offset = try data.decode(Int.self, forKey: .offset)
        
        self.characters = try data.decode([CharacterDataModel].self, forKey: .characters)
    }
}
