import Foundation

public struct CharacterDataModel: Decodable, Hashable, Identifiable, Sendable {
    public let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
}

// MARK: - Mocks

#if DEBUG

extension CharacterDataModel {
    public static var mockedHero: CharacterDataModel {
        CharacterDataModel (
            id: 1009144,
            name: "A.I.M.",
            description: "AIM is a terrorist organization bent on destroying the world.",
            thumbnail: Thumbnail(
                path: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec",
                extension: "jpg"
            )
        )
    }

    public static var mockedHeros: [CharacterDataModel] {
        [
            CharacterDataModel (
                id: 1011334,
                name: "3-D Man",
                description: "AIM is a terrorist organization bent on destroying the world.",
                thumbnail: Thumbnail(
                    path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                    extension: "jpg"
                )
            ),
            CharacterDataModel (
                id: 1017100,
                name: "Aaron Stack",
                description: "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction!",
                thumbnail: Thumbnail(
                    path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16",
                    extension: "jpg"
                )
            ),
            CharacterDataModel (
                id: 1009144,
                name: "A.I.M.",
                description: "AIM is a terrorist organization bent on destroying the world.",
                thumbnail: Thumbnail(
                    path: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec",
                    extension: "jpg"
                )
            ),
            CharacterDataModel (
                id: 1009146,
                name: "Abomination (Emil Blonsky)",
                description: "Formerly known as Emil Blonsky, a spy of Soviet Yugoslavian origin working for the KGB, the Abomination gained his powers after receiving a dose of gamma radiation similar to that which transformed Bruce Banner into the incredible Hulk.",
                thumbnail: Thumbnail(
                    path: "http://i.annihil.us/u/prod/marvel/i/mg/9/50/4ce18691cbf04",
                    extension: "jpg"
                )
            ),
            CharacterDataModel (
                id: 1016823,
                name: "Abomination (Ultimate)",
                description: "",
                thumbnail: Thumbnail(
                    path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available",
                    extension: "jpg"
                )
            ),
            CharacterDataModel (
                id: 1009148,
                name: "Absorbing Man",
                description: "",
                thumbnail: Thumbnail(
                    path: "http://i.annihil.us/u/prod/marvel/i/mg/1/b0/5269678709fb7",
                    extension: "jpg"
                )
            ),
            CharacterDataModel (
                id: 1009149,
                name: "Abyss",
                description: "",
                thumbnail: Thumbnail(
                    path: "http://i.annihil.us/u/prod/marvel/i/mg/9/30/535feab462a64",
                    extension: "jpg"
                )
            ),
            CharacterDataModel (
                id: 1011266,
                name: "Adam Destine",
                description: "",
                thumbnail: Thumbnail(
                    path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available",
                    extension: "jpg"
                )
            )
        ]
    }
}
#endif
