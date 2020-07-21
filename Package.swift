// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIAdapterKit",
    platforms: [.iOS(.v9)],
    products: [
        .library(
            name: "UIAdapterKit",
            targets: ["UIAdapterKit"]),
        .library(
  	    name: "UIAdapterKit/Realm",
            targets: ["UIAdapterKit/Realm"]),
        .library(
	    name: "UIAdapterKit/Common",
 	    targets: ["UIAdapterKit/Common"]),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/realm-cocoa.git", from: "5.0.0"),

	// Test dependencies
	//.package(url: "https://github.com/vadymmarkov/Fakery.git", from: "4.1.1")
    ],
    targets: [
        .target(
            name: "UIAdapterKit",
            dependencies: [],
            path: "UIAdapterKit"),
        .target(
            name: "UIAdapterKit/Realm",
            dependencies: ["UIAdapterKit", "RealmSwift"],
            path: "UIAdapterKit-Realm"),
	.target(
 	    name: "UIAdapterKit/Common",
	    dependencies: ["UIAdapterKit"],
	    path: "UIAdapterKit-Common"),

        //.testTarget(
        //    name: "UIAdapterKitTests",
        //    dependencies: ["UIAdapterKit", "UIAdapterKit/Realm", "UIAdapterKit/Common",  "RealmSwift", "Fakery"],
        //    path: "Example/Tests")
    ],
    swiftLanguageVersions: [.v5]
)
