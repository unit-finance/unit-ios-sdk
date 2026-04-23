// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "UnitSDK",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "UnitCommon", targets: ["UnitCommon"]),
        .library(name: "UnitFraud",  targets: ["UnitCommon", "UnitFraud", "UnitFraudDeps"]),
        .library(name: "UnitSDK",    targets: ["UnitCommon", "UnitFraud", "UnitFraudDeps", "UnitSDK"]),
    ],
    dependencies: [
        .package(url: "https://github.com/socure-inc/socure-sigmadevice-sdk-ios", .upToNextMinor(from: "4.8.1"))
    ],
    targets: [
        .binaryTarget(name: "UnitCommon", path: "UnitCommon.xcframework"),
        .binaryTarget(name: "UnitFraud",  path: "UnitFraud.xcframework"),
        .binaryTarget(name: "UnitSDK",    path: "UnitSDK.xcframework"),
        .target(
            name: "UnitFraudDeps",
            dependencies: [
                .product(name: "DeviceRisk", package: "socure-sigmadevice-sdk-ios")
            ],
            path: "Sources/UnitFraudDeps"
        ),
    ]
)
