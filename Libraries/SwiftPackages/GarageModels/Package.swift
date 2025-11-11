// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GarageModels",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "GarageModels",
            targets: ["GarageModels"]),
    ],
    targets: [
        .target(
            name: "GarageModels"
        )
    ]
)
