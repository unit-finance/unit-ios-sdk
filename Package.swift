// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "UnitSDK",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "UnitFraud", targets: ["UnitFraudWrapper"]),
        .library(name: "UnitSDK",   targets: ["UnitSDKWrapper"]),
    ],
    dependencies: [
        .package(url: "https://github.com/socure-inc/socure-sigmadevice-sdk-ios", .upToNextMinor(from: "4.8.1"))
    ],
    targets: [
        // Binary targets — not exposed as standalone products
        .binaryTarget(name: "UnitCommon", path: "UnitCommon.xcframework"),
        .binaryTarget(name: "UnitFraud",  path: "UnitFraud.xcframework"),
        .binaryTarget(name: "UnitSDK",    path: "UnitSDK.xcframework"),

        // Wrapper targets — declare all dependencies so SPM links them automatically
        .target(
            name: "UnitFraudWrapper",
            dependencies: [
                .target(name: "UnitCommon", condition: .when(platforms: [.iOS])),
                .target(name: "UnitFraud",  condition: .when(platforms: [.iOS])),
                .product(name: "DeviceRisk", package: "socure-sigmadevice-sdk-ios")
            ],
            path: "Sources/UnitFraudWrapper"
        ),
        .target(
            name: "UnitSDKWrapper",
            dependencies: [
                .target(name: "UnitCommon", condition: .when(platforms: [.iOS])),
                .target(name: "UnitFraud",  condition: .when(platforms: [.iOS])),
                .target(name: "UnitSDK",    condition: .when(platforms: [.iOS])),
                .product(name: "DeviceRisk", package: "socure-sigmadevice-sdk-ios")
            ],
            path: "Sources/UnitSDKWrapper"
        ),
    ]
)
