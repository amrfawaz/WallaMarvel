//
//  HeroInfoItem.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 25/05/2025.
//

import Foundation

public struct HeroInfoList: Decodable, Sendable, Hashable {
    public let items: [HeroInfoItem]
}

public struct HeroInfoItem: Decodable, Sendable, Hashable {
    public let name: String
}
