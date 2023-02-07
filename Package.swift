// swift-tools-version:5.5
//
// The `swift-tools-version` declares the minimum version of Swift required to
// build this package. Do not remove it.

import PackageDescription

let package = Package(
  name: "NordicDFU",
  platforms: [
    .macOS(.v10_14),
    .iOS(.v9),
    .watchOS(.v4),
    .tvOS(.v11)
  ],
  products: [
    .library(name: "NordicDFU", type: .dynamic, targets: ["NordicDFU"]),
    .library(name: "NordicDFUStatic", type: .static, targets: ["NordicDFU"])
  ],
  dependencies: [
    .package(
      url: "https://github.com/mateusforgi/ZIPFoundation",
      revision: "c250f5ab6040a77c947ebaa87e43cf102a0f86db"
    )
  ],
  targets: [
    .target(
      name: "NordicDFU",
      dependencies: ["ZIPFoundation"],      
      path: "iOSDFULibrary/Classes/"
    ),
    // FIXME: Exclude this target for `watchOS` Simulator, because it fails to
    // compile in Xcode.
    .testTarget(
      name: "Hex2BinConverterTests",
      dependencies: ["NordicDFU"],
      path: "Example/Tests/"
    )
  ],
  swiftLanguageVersions: [.v5]
)
