//
//  HeroViewModel.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 24/05/2025.
//

import Combine
import Foundation
import SharedModels

private enum Constant {
    static let imageSize = "/detail."
}
enum HeroViewAction {
    case didTapHeroCard
}

final class HeroViewModel: ObservableObject {
    @Published var hero: CharacterDataModel

    let subject = PassthroughSubject<HeroViewAction, Never>()

    init(hero: CharacterDataModel) {
        self.hero = hero
    }

    var name: String {
        hero.name
    }

    var image: String {
        hero.thumbnail.path + Constant.imageSize + hero.thumbnail.extension
    }

    var description: String {
        hero.description
    }
}

#if DEBUG
extension HeroViewModel {
    static var mockHeroViewModel: HeroViewModel {
        HeroViewModel(hero: .mockedHero1)
    }
}
#endif
