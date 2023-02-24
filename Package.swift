// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "NordicDFUDynamic",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "NordicDFUDynamic",
            type: .dynamic,
            targets: ["NordicDFUDynamic"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/NordicSemiconductor/IOS-DFU-Library", .exact("4.12.0")),
    ],
    targets: [
        .target(
            name: "NordicDFUDynamic",
            dependencies: [.product(name: "NordicDFU", package: "IOS-DFU-Library")]
        ),
    ]
)
