//  Copyright (C) 2019  Nick Platt
//
//  This library is free software; you can redistribute it and/or
//  modify it under the terms of the GNU Lesser General Public
//  License as published by the Free Software Foundation; either
//  version 2.1 of the License, or (at your option) any later version.
//
//  This library is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
//  Lesser General Public License for more details.

// Part of OGS Real Time API
// https://ogs.readme.io/docs/real-time-api

// swiftlint:disable identifier_name

// MARK: - outbound

/// Ping the server.
/// Path: `net/ping`
struct Ping: Codable {
  let client: Int64
  let drift: Float64
  let latency: Int64
}

// MARK: - incoming

/// Response from a ping.
/// Path: `net/pong`
struct Pong: Codable {
  let client: Int64
  let server: Int64
}
