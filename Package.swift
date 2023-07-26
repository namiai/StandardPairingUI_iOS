// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StandardPairingUI",
    // The supported platform version here couldn't be lower than in Tomonari.
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "StandardPairingUI",
            targets: ["StandardPairingUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/namiai/I18n_iOS.git", branch: "main"),
        .package(url: "https://github.com/namiai/NamiTextStyle_iOS.git", branch: "main"),
        .package(url: "https://github.com/namiai/Tomonari.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "StandardPairingUI",
            dependencies: [
                .product(name: "I18n", package: "I18n_iOS"),
                .product(name: "NamiTextStyle", package: "NamiTextStyle_iOS"),
                .product(name: "Tomonari", package: "Tomonari"),
            ]),
    ]
)
