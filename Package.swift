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
            url: "https://github.com/ealtaca/SimKitSDK-Binary/releases/download/1.4.0/SimKit.xcframework.zip",
            checksum: "694d3b9564cc6c608c1e19036a305c634c0718d0808f76cb49dba4de7bf034dd"
        )
    ]
)
