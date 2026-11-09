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
            url: "https://github.com/ealtaca/SimKitSDK-Binary/releases/download/1.9.0-beta.2/SimKit.xcframework.zip",
            checksum: "9293182621f8982506120df05bb2b12ab3cfb37edc35856390b637c62ff0f798"
        )
    ]
)
