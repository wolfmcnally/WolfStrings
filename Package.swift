// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "WolfStrings",
    products: [
        .library(
            name: "WolfStrings",
            targets: ["WolfStrings"]),
        ],
    dependencies: [
        .package(url: "https://github.com/wolfmcnally/WolfNumerics", from: "3.0.1"),
        .package(url: "https://github.com/wolfmcnally/WolfPipe", from: "1.1.1"),
        .package(url: "https://github.com/wolfmcnally/WolfOSBridge", from: "1.1.1"),
        .package(url: "https://github.com/wolfmcnally/WolfWith", from: "1.0.3"),
        .package(url: "https://github.com/wolfmcnally/ExtensibleEnumeratedName", from: "1.0.4"),
    ],
    targets: [
        .target(
            name: "WolfStrings",
            dependencies: ["WolfNumerics", "WolfPipe", "WolfOSBridge", "WolfWith", "ExtensibleEnumeratedName"])
        ]
)
