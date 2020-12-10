// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIAdapterKit",
    platforms: [.iOS(.v9)],
    products: [
        .library(
            name: "UIAdapterKit",
            targets: ["UIAdapterKit"]
	),
        .library(
  	    name: "UIAdapterKit_Realm",
            targets: ["UIAdapterKit_Realm"]
	),
        .library(
	    name: "UIAdapterKit_Common",
 	    targets: ["UIAdapterKit_Common"]
	),
    ],
    dependencies: [
        .package(name: "Realm", url: "https://github.com/realm/realm-cocoa.git", from: "5.0.0"),

	// Test dependencies
	.package(url: "https://github.com/vadymmarkov/Fakery.git", from: "5.0.0")
    ],
    targets: [
        .target(
            name: "UIAdapterKit",
            dependencies: [],
            path: "UIAdapterKit"
	),
        .target(
            name: "UIAdapterKit_Realm",
            dependencies: [
		"UIAdapterKit",
		.product(name: "RealmSwift", package: "Realm")
	    ],
            path: "UIAdapterKit-Realm"
	),
	.target(
 	    name: "UIAdapterKit_Common",
	    dependencies: [
		"UIAdapterKit",
	    ],
	    path: "UIAdapterKit-Common"
	),

        .testTarget(
            name: "UIAdapterKitTests",
            dependencies: [
		"UIAdapterKit", 
		"UIAdapterKit_Realm", 
		"UIAdapterKit_Common",
		.product(name: "RealmSwift", package: "Realm"),
		"Fakery"
	    ],
            path: "Example/Tests"
	)
    ],
    swiftLanguageVersions: [.v5]
)
