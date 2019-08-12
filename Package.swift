// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UICollectionViewLeftAlignedLayout-Swift",
    products: [
        .library(
            name: "UICollectionViewLeftAlignedLayout-Swift",
            targets: ["UICollectionViewLeftAlignedLayout-Swift"]),
    ],
    targets: [
        .target(
            name: "UICollectionViewLeftAlignedLayout-Swift",
            path: "UICollectionViewLeftAlignedLayout-Swift"
        ),
    ]
)
