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
      url: "https://github.com/weichsel/ZIPFoundation",
      .exact("0.9.11")
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
      dependencies: ["NordicDFUInternal", "ZIPFoundationDynamic"],
      path: "NordicDFUDynamic/"
    ),
    .target(
      name: "ZIPFoundationDynamic",
      dependencies: ["ZIPFoundation"],
      path: "ZIPFoundationDynamic/"
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
