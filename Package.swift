// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StandardPairingUI",
    // The supported platform version here couldn't be lower than in Tomonari.
    platforms: [
        .iOS("16.0"),
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "StandardPairingUI",
            targets: ["StandardPairingUI"]
        ),
    ],
    dependencies: [
        .package(path: "../I18n_iOS"),
        .package(path: "../NamiSharedUIElements_iOS"),
        .package(path: "../SharedAssets_iOS"),
        .package(path: "../Tomonari"),
        .package(path: "../CommonTypes_iOS"),
        .package(path: "../NamiProto_iOS"),
    ],
    targets: [
        .target(
            name: "StandardPairingUI",
            dependencies: [
                .product(name: "NamiI18n", package: "I18n_iOS"),
                .product(name: "NamiSharedUIElements", package: "NamiSharedUIElements_iOS"),
                .product(name: "SharedAssets", package: "SharedAssets_iOS"),
                .product(name: "Tomonari", package: "Tomonari"),
                .product(name: "CommonTypes", package: "CommonTypes_iOS"),
                .product(name: "NamiProto", package: "NamiProto_iOS"),
            ]
        ),
    ]
)
