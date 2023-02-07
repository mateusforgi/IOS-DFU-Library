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
      revision: "d231a24b468f8cbb071f3f01c3f06449236e1d92"
    )
  ],
  targets: [
    .target(
      name: "NordicDFU",
      dependencies: ["ZIPFoundation"],
      path: "iOSDFULibrary/Classes/"
    ),
    .target(
      name: "NordicDFUDynamic",
      dependencies: [
          .product(name: "ZIPFoundationDynamic", package: "ZIPFoundation")
      ],
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
