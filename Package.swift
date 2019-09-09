// swift-tools-version:5.1

import PackageDescription

let package = Package(
  name: "OnlineGo",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15),
  ],
  products: [
    .library(
      name: "OnlineGo",
      targets: ["OnlineGo"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
    .package(url: "https://github.com/socketio/socket.io-client-swift", from: "15.1.0"),
  ],
  targets: [
    .target(
      name: "OnlineGo",
      dependencies: [
        "Logging",
        "SocketIO",
      ]),
  ]
)
