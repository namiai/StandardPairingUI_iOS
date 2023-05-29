// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StandardPairingUI",
    platforms: [.iOS(.v14), .macOS(.v10_15)],
    products: [
        .library(
            name: "StandardPairingUI",
            targets: ["StandardPairingUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/namiai/Tomonari.git", branch: "porting_main_app_changes"),
    ],
    targets: [
        .target(
            name: "StandardPairingUI",
            dependencies: [
                .product(name: "Tomonari", package: "Tomonari"),
            ]),
    ]
)
