// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GarageServices",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "GarageServices",
            targets: ["GarageServices"]),
    ],
    dependencies: [
        .package(path: "../CoreModules/GarageBackend"),
        .package(path: "../GarageModels"),
    ],
    targets: [
        .target(
            name: "GarageServices",
            dependencies: [
                .product(name: "GarageBackend", package: "GarageBackend"),
                .product(name: "GarageModels", package: "GarageModels"),
            ]
        )
    ]
)
