// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "WolfStrings",
    products: [
        .library(
            name: "WolfStrings",
            targets: ["WolfStrings"]),
        ],
    dependencies: [
        .package(url: "https://github.com/wolfmcnally/WolfNumerics", from: "4.0.0"),
        .package(url: "https://github.com/wolfmcnally/WolfPipe", from: "2.0.0"),
        .package(url: "https://github.com/wolfmcnally/WolfOSBridge", from: "2.0.0"),
        .package(url: "https://github.com/wolfmcnally/WolfWith", from: "2.0.0"),
        .package(url: "https://github.com/wolfmcnally/ExtensibleEnumeratedName", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "WolfStrings",
            dependencies: ["WolfNumerics", "WolfPipe", "WolfOSBridge", "WolfWith", "ExtensibleEnumeratedName"])
        ]
)
