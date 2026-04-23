// swift-tools-version:5.5
import PackageDescription

let unitFraudWrapper = "UnitFraudWrapper"
let unitSDKWrapper   = "UnitSDKWrapper"

func createProducts() -> [Product] {
    [
        .library(name: "UnitFraud", targets: [unitFraudWrapper]),
        .library(name: "UnitSDK",   targets: [unitSDKWrapper]),
    ]
}

func createDependencies() -> [Package.Dependency] {
    [
        .package(
            url: "https://github.com/socure-inc/socure-sigmadevice-sdk-ios",
            .upToNextMinor(from: "4.8.1")
        )
    ]
}

func createTargets() -> [Target] {
    var targets = [Target]()

    // Binary xcframeworks — not exposed as standalone products
    targets.append(.binaryTarget(name: "UnitCommon", path: "UnitCommon.xcframework"))
    targets.append(.binaryTarget(name: "UnitFraud",  path: "UnitFraud.xcframework"))
    targets.append(.binaryTarget(name: "UnitSDK",    path: "UnitSDK.xcframework"))

    // UnitFraud wrapper — pulls in UnitFraud + UnitCommon xcframeworks and DeviceRisk
    targets.append(.target(
        name: unitFraudWrapper,
        dependencies: [
            .target(name: "UnitCommon", condition: .when(platforms: [.iOS])),
            .target(name: "UnitFraud",  condition: .when(platforms: [.iOS])),
            .product(name: "DeviceRisk", package: "socure-sigmadevice-sdk-ios"),
        ],
        path: "Sources/\(unitFraudWrapper)"
    ))

    // UnitSDK wrapper — pulls in all three xcframeworks and DeviceRisk
    targets.append(.target(
        name: unitSDKWrapper,
        dependencies: [
            .target(name: "UnitCommon", condition: .when(platforms: [.iOS])),
            .target(name: "UnitFraud",  condition: .when(platforms: [.iOS])),
            .target(name: "UnitSDK",    condition: .when(platforms: [.iOS])),
            .product(name: "DeviceRisk", package: "socure-sigmadevice-sdk-ios"),
        ],
        path: "Sources/\(unitSDKWrapper)"
    ))

    return targets
}

let package = Package(
    name: "UnitSDK",
    platforms: [
        .iOS(.v15)
    ],
    products:     createProducts(),
    dependencies: createDependencies(),
    targets:      createTargets()
)
