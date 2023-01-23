// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TogglerCore",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "TogglerService",
            targets: ["TogglerService"]),
    ],
    dependencies: [
        .package(name: "Moya", url: "https://github.com/Moya/Moya.git", from: "15.0.3"),
    ],
    targets: [
        .target(
            name: "TogglerService",
            dependencies: ["Project",
                           "TimeEntry",
                           "Workspace",
                           "Me",
                           "DomainService"]),
        .target(name: "Project", dependencies: ["TogglerCore", "Workspace"]),
        .target(name: "TimeEntry", dependencies: ["TogglerCore", "Project", "Workspace"]),
        .target(name: "Workspace", dependencies: ["TogglerCore"]),
        .target(name: "Me", dependencies: ["TogglerCore"]),
        .target(name: "DomainService", dependencies: ["TogglerCore", "TimeEntry"]),
        .target(name: "TogglerCore", dependencies: ["Moya"])

    ]
)
