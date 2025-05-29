// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Packages",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "EnvironmentVariables",
            targets: ["EnvironmentVariables"]),
        .library(
            name: "NetworkProvider",
            targets: ["NetworkProvider"]),
        .library(
            name: "CoreStyles",
            targets: ["CoreStyles"]),
        .library(
            name: "Helpers",
            targets: ["Helpers"]),
        .library(
            name: "HeroesList",
            targets: ["HeroesList"]),
        .library(
            name: "HeroDetails",
            targets: ["HeroDetails"]),
        .library(
            name: "SharedModels",
            targets: ["SharedModels"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "EnvironmentVariables",
            dependencies: [],
            path: "EnvironmentVariables/Sources"
        ),
        .target(
            name: "NetworkProvider",
            dependencies: [
                "EnvironmentVariables"],
            path: "NetworkProvider/Sources"
        ),
        .target(
            name: "CoreStyles",
            dependencies: [],
            path: "CoreStyles/Sources"
        ),
        .target(
            name: "Helpers",
            dependencies: [],
            path: "Helpers/Sources"
        ),
        .target(
            name: "HeroesList",
            dependencies: [
                "CoreStyles",
                "EnvironmentVariables",
                "NetworkProvider",
                "Helpers",
                "SharedModels",
                "HeroDetails"
            ],
            path: "HeroesList/Sources"
        ),
        .target(
            name: "HeroDetails",
            dependencies: [
                "CoreStyles",
                "EnvironmentVariables",
                "NetworkProvider",
                "Helpers",
                "SharedModels"
            ],
            path: "HeroDetails/Sources"
        ),
        .target(
            name: "SharedModels",
            dependencies: [],
            path: "SharedModels/Sources"
        ),

        
        
        // MARK: - Test Targets
        
        .testTarget(
            name: "HeroesListTests",
            dependencies: [
                "HeroesList"
            ],
            path: "HeroesList/Tests"
        )
    ]
)
