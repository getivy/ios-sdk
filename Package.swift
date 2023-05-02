// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "GetivySDK",
    platforms: [.iOS(.v11)],
    products: [
        .library(name: "GetivySDK", targets: ["GetivySDK"])
    ],
    targets: [
        .target(
            name: "GetivySDK",
            path: "GetivySDK/Source"
        ),
        .testTarget(
            name: "GetivySDKTests",
            dependencies: ["GetivySDK"],
            path: "GetivySDKTests"
        )
    ]
)
