// swift-tools-version:5.5
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
        // Binary targets
        .binaryTarget(name: "UnitCommon", path: "UnitCommon.xcframework"),
        .binaryTarget(name: "_UnitFraud", path: "UnitFraud.xcframework"),
        .binaryTarget(name: "_UnitSDK", path: "UnitSDK.xcframework"),

        // Wrapper targets so SPM knows the dependency graph
        .target(
            name: "UnitFraud",
            dependencies: ["_UnitFraud", "UnitCommon"],
            path: "Sources/UnitFraud"
        ),
        .target(
            name: "UnitSDK",
            dependencies: ["_UnitSDK", "UnitFraud", "UnitCommon"],
            path: "Sources/UnitSDK"
        ),
    ]
)
