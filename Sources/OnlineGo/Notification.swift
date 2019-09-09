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

/// Path: `notification/connect`
public struct NotificationConnect: Codable {
  public let auth: String
  public let playerId: Int64
}

/// Path: `notification/delete`
public struct NotificationDelete: Codable {
  public let auth: String
  public let playerId: Int64
  public let notificationId: String  // <player-id>:<uuid>
}

// MARK: - inbound

/// A notification.
/// Path: `notification`
public struct NotificationEvent: Codable {
  public let id: Int64  // notification_id
  public let type: NotificationType

  // present for game* notifications
  public let auxDelivered: Int64?  // ???
  public let black: String?  // username
  public let gameId: Int64?

  public let name: String?
  public let playerId: Int64?
  public let read: BoolOrInt?
  public let readTimestamp: Int64?
  public let white: String?  // username

  // present for gameEnded
  public let outcome: Outcome?

  public let annulled: Bool?
  public let whiteLost: Bool?
  public let blackLost: Bool?
}

// MARK: - types

/// A notification type.
public enum NotificationType: String, Codable {
  case aiReviewDone
  case challenge
  case friendAccepted
  case friendDeclined
  case friendRequest
  case gameDeclined
  case gameEnded
  case gameEnteredStoneRemoval
  case gameResumedFromStoneRemoval
  case gameStarted
  case groupInvitation
  case groupNews
  case groupRequest
  case timecop
  case tournamentEnded
  case tournamentInvitation
  case tournamentStarted
}
