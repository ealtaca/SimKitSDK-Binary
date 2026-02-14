// swift-tools-version:5.9
// SimKit SDK - Closed Source Distribution
// https://github.com/ealtaca/SimKitSDK-Binary

import PackageDescription

let package = Package(
    name: "SimKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "SimKit",
            targets: ["SimKit"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "SimKit",
            url: "https://github.com/ealtaca/SimKitSDK-Binary/releases/download/1.2.0/SimKit.xcframework.zip",
            checksum: "47c2632805787f48034d6554c8bb7b8fabf2514dc603a6ccde1023714f30fd14"
        )
    ]
)
