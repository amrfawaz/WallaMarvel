//
//  HeroInfoListViewModel.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 26/05/2025.
//

import Foundation

final class HeroInfoListViewModel {
    private(set) var title: String
    private(set) var list: [String]

    init(
        title: String,
        list: [String]
    ) {
        self.title = title
        self.list = list
    }
}
