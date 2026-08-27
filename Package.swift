// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "UnitSDK",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "UnitFraud", targets: ["UnitFraudWrapper"]),
        .library(name: "UnitSDK",   targets: ["UnitSDKWrapper"]),
        .library(name: "UnitCommon", targets: ["UnitCommon"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/socure-inc/socure-sigmadevice-sdk-ios",
            .upToNextMinor(from: "4.8.1")
        ),
        .package(url: "https://github.com/unit-finance/unit-ios-push-provisioning.git", branch: "UD-16693/push-provisioning-sdk-implementation")
    ],
    targets: [
        .binaryTarget(name: "UnitCommon", path: "UnitCommon.xcframework"),
        .binaryTarget(name: "UnitFraud",  path: "UnitFraud.xcframework"),
        .binaryTarget(name: "UnitSDK",    path: "UnitSDK.xcframework"),
        .target(
            name: "UnitFraudWrapper",
            dependencies: [
                .target(name: "UnitCommon", condition: .when(platforms: [.iOS])),
                .target(name: "UnitFraud",  condition: .when(platforms: [.iOS])),
                .product(name: "DeviceRisk", package: "socure-sigmadevice-sdk-ios"),
            ],
            path: "UnitFraudWrapper"
        ),
        .target(
            name: "UnitSDKWrapper",
            dependencies: [
                .target(name: "UnitCommon", condition: .when(platforms: [.iOS])),
                .target(name: "UnitFraud",  condition: .when(platforms: [.iOS])),
                .target(name: "UnitSDK",    condition: .when(platforms: [.iOS])),
                .product(name: "DeviceRisk", package: "socure-sigmadevice-sdk-ios"),
                .product(name: "UnitPushProvisioning", package: "unit-ios-push-provisioning"),
            ],
            path: "UnitSDKWrapper"
        ),
    ]
)
