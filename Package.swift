// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "EmojiKit",
    products: [
        .library(
            name: "EmojiKit",
            targets: ["EmojiKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "EmojiKit",
            dependencies: [],
            resources: [.copy("emoji.json")]),
        .testTarget(
            name: "EmojiKitTests",
            dependencies: ["EmojiKit"])
    ]
)
