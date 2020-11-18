// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

var package = Package(
    name: "SwiftSytaxDemo",
    dependencies: [
        .package(name:"SwiftSyntax", url: "https://github.com/apple/swift-syntax.git", .exact("0.50300.0")),
        .package(name:"Path.swift", url: "https://github.com/mxcl/Path.swift.git", .exact("1.2.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SwiftSytaxDemo",
            dependencies: [.product(name: "Path", package: "Path.swift"),"SwiftSyntax"]),
    ]

)




