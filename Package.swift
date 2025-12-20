// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-hal",
    // TODO: Should work on linux and windows and freebsd and embedded
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
        .macCatalyst(.v13),
        .visionOS(.v1),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "HAL",
            targets: ["HAL"]
        ),
        .library(name: "RaspberryPi4HAL", targets: ["RaspberryPi4HAL"]),
        .library(name: "RaspberryPiPicoHAL", targets: ["RaspberryPiPicoHAL"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-mmio", .upToNextMajor(from: "0.1.1")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "HAL"
        ),
        .target(
            name: "RaspberryPi4HAL",
            dependencies: [
                "HAL",
                .product(name: "MMIO", package: "swift-mmio"),
            ]
        ),
        .target(
            name: "RaspberryPiPicoHAL",
            dependencies: [
                .product(name: "MMIO", package: "swift-mmio"),
                "HAL"
            ]
        )
    ]
)
