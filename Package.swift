// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NamiStandardPairingSDK",
    platforms: [.iOS(.v14), .macOS(.v10_15)],
    products: [
        .library(
            name: "NamiStandardPairingSDK",
            targets: ["NamiStandardPairingSDK"]),
    ],
    dependencies: [
        .package(url: "https://github.com/namiai/Tomonari.git", branch: "remove_i18n_package"),
    ],
    targets: [
        .target(
            name: "NamiStandardPairingSDK",
            dependencies: [
                .product(name: "Tomonari", package: "Tomonari"),
            ]),
        .testTarget(
            name: "NamiStandardPairingSDKTests",
            dependencies: ["NamiStandardPairingSDK"]),
    ]
)
