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

/// Authenticate with the server.
/// Path: `authenticate`
public struct Authenticate: Codable {
  public let auth: String
  public let jwt: String
  public let playerId: Int64
  public let username: String
}

/// Connect to a chat.
/// Path: `chat/connect`
public struct ChatConnect: Codable {
  public let auth: String?
  public let playerId: Int64
  public let ranking: Int64
  public let username: String
  public let uiClass: UiClass
}

/// Join a chat.
/// Path: `chat/join`
public struct ChatJoin: Codable {
  public let channel: String
}

/// Leave a chat.
/// Path: `chat/part`
public struct ChatPart: Codable {
  public let channel: String
  public let user: ChatUser
}

/// Send a chat message.
/// Path: `chat/send`
public struct ChatSend: Codable {
  public let channel: String
  public let uuid: String
  public let message: String  // FIXME: { i, t, m } ?
  public let username: String

  public let id: Int64

  /// player_id
  public let ranking: Int64

  public let professional: Bool
  public let uiClass: UiClass
}

/// Send a private chat message.
/// Path: `chat/pm`
public struct ChatPM: Codable {
  public let playerId: Int64
  public let username: String
  public let message: String
}

/// Send a private superchat message.
/// Path: `chat/pm/superchat`
public struct ChatPMSuperchat: Codable {
  public let auth: String
  public let playerId: Int64
  public let username: String
  public let enable: Bool
}

/// Path: `chat/pm/load`
public struct ChatPMLoad: Codable {
  private let val: Int64  // player_id
}

/// Send a chat message within a game.
/// Path: `game/chat`
public struct GameChat: Codable {
  public let type: Channel
  public let gameId: Int64
  public let moveNumber: Int64
  public let body: String
}

/// Send a chat message within a review.
/// Path: `review/chat`
public struct ReviewChat: Codable {
  public let reviewId: Int64
  public let from: Int64
  public let moves: String
}

// MARK: - incoming

/// A `chat-join` event.
public struct ChatJoinEvent: Codable {
  public let channel: String
  public let users: [ChatUser]
}

/// A `chat-part` event.
public struct ChatPartEvent: Codable {
  public let channel: String
}

/// A `game/{id}/reset-chats` event.
public struct ResetChatsEvent: Codable {
  private let val: Int64
}

/// A `game/{id}/chat` event.
public struct ChatEvent: Codable {
  public let channel: Channel
  public let line: Line

  public struct Line: Codable {
    public let body: String  // TODO: Either<String, Analysis>
    public let chatId: String

    public let date: Int64
    public let moveNumber: Int64?
    public let playerId: Int64
    public let professional: BoolOrInt
    public let ranking: Int64
    public let ratings: Ratings
    public let uiClass: UiClass
    public let username: String
  }

  //  public enum LineBody: Codable {
  //    case simple(String)
  //    case analysis(Analysis)
  //  }

  // TODO
  public struct Analysis: Codable {
    public let type = "analysis"
    public let from: Int64
    public let marks: [String: String]  // FIXME: dict of turn -> sgf ?
    public let moves: String  // FIXME: concatenated sgf
    public let name: String
  }
}

// MARK: - types

/// A communication channel.
public enum Channel: String, Codable {
  case main
  case malkovich
  case spectator
}

/// A chatroom participant.
public struct ChatUser: Codable {
  public let country: String
  public let id: Int64  // player_id
  public let professional: BoolOrInt

  public let ranking: Int64
  public let ratings: Ratings
  public let uiClass: UiClass
  public let username: String
}

/// A value applied in HTML attributes.
public enum UiClass: String, Codable {
  case bot
  case moderator
}
