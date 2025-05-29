import Foundation

public struct CharacterDataModel: Decodable, Hashable, Identifiable, Sendable {
    public let id: Int
    public let name: String
    public let description: String
    public let thumbnail: Thumbnail
    public let comics: HeroInfoList
    public let series: HeroInfoList
    public let stories: HeroInfoList
}

// MARK: - Mocks

#if DEBUG

extension CharacterDataModel {
    public static var mockedHero1: CharacterDataModel {
        CharacterDataModel (
            id: 1009144,
            name: "A.I.M.",
            description: "AIM is a terrorist organization bent on destroying the world.",
            thumbnail: Thumbnail(
                path: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec",
                extension: "jpg"
                
            ),
            comics: HeroInfoList(
                items: [
                    HeroInfoItem(name: "Amazing A.I.M. #1"),
                    HeroInfoItem(name: "Amazing A.I.M. #2")
                ]
            ),
            series: HeroInfoList(
                items: [
                    HeroInfoItem(name: "A.I.M. Series")
                ]
            ),
            stories: HeroInfoList(
                items: [
                    HeroInfoItem(name: "A.I.M. Story")
                ]
            )
        )
    }

    public static var mockedHero2: CharacterDataModel {
        CharacterDataModel (
            id: 1017100,
            name: "Aaron Stack",
            description: "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction!",
            thumbnail: Thumbnail(
                path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16",
                extension: "jpg"
            ),
            comics: HeroInfoList(
                items: [
                    HeroInfoItem(name: "Amazing Aaron Stack #1"),
                    HeroInfoItem(name: "Amazing Aaron Stack #2")
                ]
            ),
            series: HeroInfoList(
                items: [
                    HeroInfoItem(name: "Aaron Stack Series")
                ]
            ),
            stories: HeroInfoList(
                items: [
                    HeroInfoItem(name: "Aaron Stack. Story")
                ]
            )
        )
    }

    public static var mockedHero3: CharacterDataModel {
        CharacterDataModel (
            id: 1009146,
            name: "Abomination (Emil Blonsky)",
            description: "Formerly known as Emil Blonsky, a spy of Soviet Yugoslavian origin working for the KGB, the Abomination gained his powers after receiving a dose of gamma radiation similar to that which transformed Bruce Banner into the incredible Hulk.",
            thumbnail: Thumbnail(
                path: "http://i.annihil.us/u/prod/marvel/i/mg/9/50/4ce18691cbf04",
                extension: "jpg"
            ),
            comics: HeroInfoList(
                items: [
                    HeroInfoItem(name: "Amazing Abomination #1"),
                    HeroInfoItem(name: "Amazing Abomination #2")
                ]
            ),
            series: HeroInfoList(
                items: [
                    HeroInfoItem(name: "Abomination Series")
                ]
            ),
            stories: HeroInfoList(
                items: [
                    HeroInfoItem(name: "Abomination Story")
                ]
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
                ),
                comics: HeroInfoList(items: []),
                series: HeroInfoList(items: []),
                stories: HeroInfoList(items: [])
            ),
            CharacterDataModel (
                id: 1017100,
                name: "Aaron Stack",
                description: "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction!",
                thumbnail: Thumbnail(
                    path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16",
                    extension: "jpg"
                ),
                comics: HeroInfoList(items: []),
                series: HeroInfoList(items: []),
                stories: HeroInfoList(items: [])
            ),
            CharacterDataModel (
                id: 1009144,
                name: "A.I.M.",
                description: "AIM is a terrorist organization bent on destroying the world.",
                thumbnail: Thumbnail(
                    path: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec",
                    extension: "jpg"
                ),
                comics: HeroInfoList(items: []),
                series: HeroInfoList(items: []),
                stories: HeroInfoList(items: [])
            ),
            CharacterDataModel (
                id: 1009146,
                name: "Abomination (Emil Blonsky)",
                description: "Formerly known as Emil Blonsky, a spy of Soviet Yugoslavian origin working for the KGB, the Abomination gained his powers after receiving a dose of gamma radiation similar to that which transformed Bruce Banner into the incredible Hulk.",
                thumbnail: Thumbnail(
                    path: "http://i.annihil.us/u/prod/marvel/i/mg/9/50/4ce18691cbf04",
                    extension: "jpg"
                ),
                comics: HeroInfoList(items: []),
                series: HeroInfoList(items: []),
                stories: HeroInfoList(items: [])
            ),
            CharacterDataModel (
                id: 1016823,
                name: "Abomination (Ultimate)",
                description: "",
                thumbnail: Thumbnail(
                    path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available",
                    extension: "jpg"
                ),
                comics: HeroInfoList(items: []),
                series: HeroInfoList(items: []),
                stories: HeroInfoList(items: [])
            ),
            CharacterDataModel (
                id: 1009148,
                name: "Absorbing Man",
                description: "",
                thumbnail: Thumbnail(
                    path: "http://i.annihil.us/u/prod/marvel/i/mg/1/b0/5269678709fb7",
                    extension: "jpg"
                ),
                comics: HeroInfoList(items: []),
                series: HeroInfoList(items: []),
                stories: HeroInfoList(items: [])
            ),
            CharacterDataModel (
                id: 1009149,
                name: "Abyss",
                description: "",
                thumbnail: Thumbnail(
                    path: "http://i.annihil.us/u/prod/marvel/i/mg/9/30/535feab462a64",
                    extension: "jpg"
                ),
                comics: HeroInfoList(items: []),
                series: HeroInfoList(items: []),
                stories: HeroInfoList(items: [])
            ),
            CharacterDataModel (
                id: 1011266,
                name: "Adam Destine",
                description: "",
                thumbnail: Thumbnail(
                    path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available",
                    extension: "jpg"
                ),
                comics: HeroInfoList(items: []),
                series: HeroInfoList(items: []),
                stories: HeroInfoList(items: [])
            )
        ]
    }
}
#endif
