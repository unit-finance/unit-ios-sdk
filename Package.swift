// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "UnitSDK",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "UnitCommon", targets: ["UnitCommon"]),
        .library(name: "UnitFraud", targets: ["UnitFraud"]),
        .library(name: "UnitSDK", targets: ["UnitSDK"]),
    ],
    targets: [
        .binaryTarget(
            name: "UnitCommon",
            url: "https://github.com/unit-finance/unit-ios-sdk/releases/download/0.0.0/UnitCommon.xcframework.zip",
            checksum: "0000000000000000000000000000000000000000000000000000000000000000" // UnitCommon
        ),
        .binaryTarget(
            name: "UnitFraud",
            url: "https://github.com/unit-finance/unit-ios-sdk/releases/download/0.0.0/UnitFraud.xcframework.zip",
            checksum: "0000000000000000000000000000000000000000000000000000000000000000" // UnitFraud
        ),
        .binaryTarget(
            name: "UnitSDK",
            url: "https://github.com/unit-finance/unit-ios-sdk/releases/download/0.0.0/UnitSDK.xcframework.zip",
            checksum: "0000000000000000000000000000000000000000000000000000000000000000" // UnitSDK
        ),
    ]
)
