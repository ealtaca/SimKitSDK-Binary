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
            url: "https://github.com/ealtaca/SimKitSDK-Binary/releases/download/1.0.9/SimKit.xcframework.zip",
            checksum: "740526e40e27fa0905ad4628aa1f5d3bba77a42ba2768d97e84187a031eaab1c"
        )
    ]
)
