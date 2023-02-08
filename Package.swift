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
    .library(name: "NordicDFU", targets: ["NordicDFU"]),
    .library(name: "NordicDFUDynamic", type: .dynamic, targets: ["NordicDFUDynamic"])
  ],
  dependencies: [
    .package(
      url: "https://github.com/mateusforgi/ZIPFoundation",
      revision: "e71588939c0875c428374d9b064b3ea801fe95a0"
    )
  ],
  targets: [
    .target(
      name: "NordicDFUInternal",
      path: "iOSDFULibrary/Classes/"
    ),
    .target(
      name: "NordicDFU",
      dependencies: ["NordicDFUInternal", "ZIPFoundation"],
      path: "NordicDFU/"
    ),
    .target(
      name: "NordicDFUDynamic",
      dependencies: ["NordicDFUInternal",
                     .product(name:  "ZIPFoundationDynamic", package: "ZIPFoundation")
      ],
      path: "NordicDFUDynamic/"
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
