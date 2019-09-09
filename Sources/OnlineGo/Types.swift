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

/// Either a boolean or int value.
public enum BoolOrInt: Codable {

  case bool(Bool)
  case int(Int64)

  public init(from decoder: Decoder) throws {
    let values = try decoder.singleValueContainer()
    if let val = try? values.decode(Bool.self) {
      self = .bool(val)
      return
    }
    if let val = try? values.decode(Int64.self) {
      self = .int(val)
      return
    }
    throw DecodingError.dataCorruptedError(
      in: values, debugDescription: "expected bool or int; found \(dump(values))")
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    switch self {
    case let .bool(val):
      try container.encode(val)
    case let .int(val):
      try container.encode(val)
    }
  }
}
