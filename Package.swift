// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "SMIClientCore",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "SMIClientCore",
            targets: ["SMIClientCore", "SMIMultimediaCommon", "SMIClientCoreWrapper"]),
        // MIAW multimedia / voice. Fork-only addition (feature-spm-migration) so
        // Salesforce1 can consume the async-messaging voice stack as SPM instead
        // of the Messaging-Multimedia-Core CocoaPod — no source changes upstream.
        .library(
            name: "SMIMultimediaCore",
            targets: ["SMIMultimediaCore", "SMIMultimediaCoreWrapper"]),
    ],
    dependencies: [
        .package(url: "https://github.com/sqlcipher/SQLCipher.swift.git", from: "4.10.0"),
        // SMIMultimediaCore links against LiveKitWebRTC; pin the exact version the
        // prebuilt xcframework was built against (matches mbwimmer/client-sdk-swift).
        .package(url: "https://github.com/livekit/webrtc-xcframework.git", .exact("137.7151.10"))
    ],
    targets: [
        .binaryTarget(
            name: "SMIClientCore",
            url: "https://salesforce-async-messaging.s3.amazonaws.com/public/ios/1.11.2/SMIClientCore-Release.xcframework.zip",
            checksum: "39fb8286a4862d86162b188174598125c5b8df6a9a7c15dbf18c0536b2ba645e"
        ),
        .binaryTarget(
            name: "SMIMultimediaCommon",
            url: "https://salesforce-async-messaging.s3.amazonaws.com/public/ios/1.11.2/SMIMultimediaCommon-Release.xcframework.zip",
            checksum: "4345b7483d266f1312d6799fcccb387859308457028463d5204f3bde2c5a6930"
        ),
        .binaryTarget(
            name: "SMIMultimediaCore",
            url: "https://salesforce-async-messaging.s3.amazonaws.com/public/ios/1.11.2/SMIMultimediaCore-Release.xcframework.zip",
            checksum: "787d96e65e2521c43b9067b3ea13db3fb26d0ab02f3ade1b8f56602e39f2532e"
        ),
        .target(
            name: "SMIClientCoreWrapper",
            dependencies: [
                "SMIClientCore",
                .product(name: "SQLCipher", package: "SQLCipher.swift")
            ],
            cSettings: [
                .define("SQLITE_HAS_CODEC", to: nil)
            ]
        ),
        .target(
            name: "SMIMultimediaCoreWrapper",
            dependencies: [
                "SMIMultimediaCore",
                "SMIMultimediaCommon",
                .product(name: "LiveKitWebRTC", package: "webrtc-xcframework")
            ]
        )
    ]
)
