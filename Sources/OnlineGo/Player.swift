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

// MARK: outbound

/// Subscribe to user online status.
/// Path:  `user/monitor`
public struct UserMonitor: Codable {
  public let val: [Int64]  // [player_id]
}

// MARK: incoming

/// User online status.
/// Path:  `user/state`
public struct UserState: Codable {
  public let val: [Int64: BoolOrInt]  // [player_id : status]
}

// MARK: - types

/// A player.
public struct Player: Codable {
  public let accepted: Bool?  // included in `active_game` messages
  public let egf: Float64

  public let id: Int64
  public let professional: Bool
  public let rank: Float64
  public let ratings: Ratings?
  public let username: String
}

/// A player's rating in the Glicko system. 
public struct Ratings: Codable {
  public let overall: Overall

  public struct Overall: Codable {
    public let deviation: Float64
    public let gamesPlayed: Int64
    public let rating: Float64
    public let volatility: Float64
  }
}
