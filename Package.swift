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
            url: "https://github.com/ealtaca/SimKitSDK-Binary/releases/download/1.7.0/SimKit.xcframework.zip",
            checksum: "9c3d05de491965202e4b2cfb57d12e6fa0eae3a580ca05f03d5af7dfee33c908"
        )
    ]
)
