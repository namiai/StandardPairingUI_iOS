// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StandardPairingUI",
    // The supported platform version here couldn't be lower than in Tomonari.
    platforms: [
        .iOS("16.6"),
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "StandardPairingUI",
            targets: ["StandardPairingUI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/namiai/I18n_iOS.git", branch: "main"),
        .package(url: "https://github.com/namiai/NamiSharedUIElements_iOS.git", branch: "main"),
        .package(url: "https://github.com/namiai/SharedAssets_iOS", branch: "main"),
        .package(url: "https://github.com/namiai/Tomonari.git", branch: "main"),
        .package(url: "https://github.com/weitieda/bottom-sheet", exact: "1.0.8"), // Matches the version of BottomSheet used in main app.
    ],
    targets: [
        .target(
            name: "StandardPairingUI",
            dependencies: [
                .product(name: "I18n", package: "I18n_iOS"),
                .product(name: "NamiSharedUIElements", package: "NamiSharedUIElements_iOS"),
                .product(name: "SharedAssets", package: "SharedAssets_iOS"),
                .product(name: "Tomonari", package: "Tomonari"),
                .product(name: "BottomSheet", package: "bottom-sheet"),
            ]
        ),
    ]
)
