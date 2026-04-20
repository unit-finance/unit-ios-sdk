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
        .binaryTarget(name: "UnitCommon", path: "UnitCommon.xcframework"),
        .binaryTarget(name: "UnitFraud", path: "UnitFraud.xcframework"),
        .binaryTarget(name: "UnitSDK", path: "UnitSDK.xcframework"),
    ]
)
