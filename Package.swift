// swift-tools-version:4.0

import PackageDescription

let package = Package(
	name: "Hello",
	products: [
		.library(name: "App", targets: ["App"]),
		.executable(name: "Run", targets: ["Run"])
	],
	dependencies: [
		.package(url: "https://github.com/vapor/vapor.git", .upToNextMajor(from: "2.2.2")),
		.package(url: "https://github.com/vapor/fluent-provider.git", .upToNextMajor(from: "1.2.0")),
		.package(url: "https://github.com/vapor/leaf-provider.git", .upToNextMajor(from: "1.1.0")),
		.package(url: "https://github.com/vapor/validation-provider.git", .upToNextMajor(from: "1.2.0")),
		.package(url: "https://github.com/vapor-community/postgresql-provider.git", .upToNextMajor(from: "2.0.0")),
		],
	targets: [
		.target(name: "App", dependencies: ["Vapor", "FluentProvider", "LeafProvider", "ValidationProvider", "PostgreSQLProvider"],
		        exclude: [
					"Config",
					"Database",
					"Localization",
					"Public",
					"Resources",
					]),
		.testTarget(name: "AppTests", dependencies: ["App"]),
		.target(name: "Run", dependencies: ["App"])
	]
)
