// swift-tools-version: 6.0
//
// Nightcrawler: one Mac app that brings forward a site's tab in the right Chrome
// account, or opens it there. NightcrawlerCore is the pure logic and carries every
// test; NightcrawlerChrome is the live side (Apple Events, Accessibility, launching
// Chrome); NightcrawlerApp receives nightcrawler:// links; nightcrawler is the CLI.
// scripts/bundle.sh puts the app and the CLI into one Nightcrawler.app.

import PackageDescription

let package = Package(
    name: "Nightcrawler",
    platforms: [.macOS(.v13)],
    products: [
        .executable(name: "NightcrawlerApp", targets: ["NightcrawlerApp"]),
        .executable(name: "nightcrawler", targets: ["nightcrawler"]),
    ],
    dependencies: [
        .package(url: "https://github.com/jpsim/Yams.git", exact: "6.2.2"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", exact: "1.8.2"),
    ],
    targets: [
        .target(
            name: "NightcrawlerCore",
            dependencies: [.product(name: "Yams", package: "Yams")]
        ),
        .target(
            name: "NightcrawlerChrome",
            dependencies: ["NightcrawlerCore"]
        ),
        .executableTarget(
            name: "NightcrawlerApp",
            dependencies: ["NightcrawlerCore", "NightcrawlerChrome"]
        ),
        .executableTarget(
            name: "nightcrawler",
            dependencies: [
                "NightcrawlerCore",
                "NightcrawlerChrome",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .testTarget(
            name: "NightcrawlerCoreTests",
            dependencies: ["NightcrawlerCore"]
        ),
    ]
)
