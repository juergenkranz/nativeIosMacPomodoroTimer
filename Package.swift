// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PomodoroApp",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .executable(name: "PomodoroApp", targets: ["PomodoroApp"])
    ],
    targets: [
        .executableTarget(
            name: "PomodoroApp",
            path: "Sources/PomodoroApp"
        )
    ]
)
