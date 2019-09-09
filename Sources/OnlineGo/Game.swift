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
// swiftlint:disable file_length

// MARK: - outbound

/// Connect to a game.
/// Path: `game/connect`
public struct GameConnect: Codable {
  public let chat: BoolOrInt
  public let gameId: Int64
  public let playerId: Int64
}

/// Disconnect from a game.
/// Path: `game/disconnect`
public struct GameDisconnect: Codable {
  public let gameId: Int64
}

/// Pause a game.
/// Path: `game/pause`
public struct GamePause: Codable {
  public let gameId: Int64
  public let playerId: Int64
}

/// Resume a game.
/// Path: `game/resume`
public struct GameResume: Codable {
  public let gameId: Int64
  public let playerId: Int64
}

/// Cancel a game.
/// Path: `game/cancel`
public struct GameCancel: Codable {
  public let gameId: Int64
  public let playerId: Int64
}

/// Resign from a game.
/// Path: `game/resign`
public struct GameResign: Codable {
  public let gameId: Int64
  public let playerId: Int64
}

/// Annul a game (reset to move 0).
/// Path: `game/annul`
public struct GameAnnul: Codable {
  public let gameId: Int64
  public let playerId: Int64
}

/// Play a stone at a point.
/// Path: `game/move`
public struct GameMove: Codable {
  public let gameId: Int64
  public let playerId: Int64
  public let move: PointSGF
}

/// Prepare a list of conditional moves.
/// Path: `game/conditional_moves/set`
public struct GameConditionalMoves: Codable {
  public let gameId: Int64
  public let playerId: Int64?
  public let moveNumber: Int64
  public let cmoves: [ConditionalMovesDict]?
}

/// Request to undo a move.
/// Path: `game/undo/request`
public struct GameUndoRequest: Codable {
  public let gameId: Int64
  public let playerId: Int64
  public let moveNumber: Int64
}

/// Accept an undo request.
/// Path: `game/undo/accept`
public struct GameUndoAccept: Codable {
  public let gameId: Int64
  public let playerId: Int64
  public let moveNumber: Int64
}

/// Select stones to remove.
// Path: `game/removed_stones/set`
public struct GameRemovedStonesSet: Codable {
  public let gameId: Int64
  public let playerId: Int64
  public let removed: Bool
  public let stones: [PointSGF]?
  public let strictSekiMode: Bool
}

/// Accept the stones as dead.
// Path: `game/removed_stones/accept`
public struct GameRemovedStonesAccept: Codable {
  public let gameId: Int64
  public let playerId: Int64
  public let stones: [PointSGF]
  public let strictSekiMode: Bool
}

/// Reject the stones as dead.
// Path: `game/removed_stones/reject`
public struct GameRemovedStonesReject: Codable {
  public let gameId: Int64
  public let playerId: Int64
}

// MARK: - incoming

// Contains game data for the current game.
// Path: `active_game`
public struct ActiveGameEvent: Codable {
  public let black: Player
  public let height: Int
  public let id: Int64
  public let moveNumber: Int64
  public let name: String
  public let paused: BoolOrInt
  public let phase: Phase
  public let playerToMove: Int64
  public let `private`: Bool
  public let timePerMove: Int64
  public let white: Player
  public let width: Int
}

/// Indicates a move was played.
/// Path: `game/{id}/move`
public struct GameMoveEvent: Codable {
  public let gameId: Int64
  public let moveNumber: Int64
  public let move: MoveSpec
}

/// Contains the server-side conditional-moves state.
/// Path: `game/{id}/conditional_moves`
public struct GameConditionalMovesEvent: Codable {
  public let playerId: Int64?
  public let moveNumber: Int64
  public let moves: [ConditionalMovesDict]?
}

/// Indicates an undo request.
/// Path: `game/{id}/undo_requested`
public struct GameUndoRequestedEvent: Codable {
  public let moveNumber: Int64
}

/// Indicates an undo request was accepted.
/// Path: `game/{id}/undo_accepted`
public struct GameUndoAcceptedEvent: Codable {
  public let moveNumber: Int64
}

/// Indicates the stones to be removed have changed.
/// Path: `game/{id}/removed_stones`
public struct GameRemovedStonesEvent: Codable {
  public let allRemoved: [PointSGF]
  public let gameId: Int64
  public let removed: Bool
  public let stones: [PointSGF]
}

/// Indicates the removed stones were accepted.
/// Path: `game/{id}/removed_stones/accept`
public struct GameRemovedStonesAcceptEvent: Codable {
  public let gameId: Int64
  public let playerId: Int64
  public let stones: [PointSGF]
  public let strictSekiMode: Bool
}

/// Indicates the client should sync to the server.
/// Path: `game/{id}/reset`
public struct GameResetEvent: Codable {
  public let gameId: Int64
  public let message: String
  public let gamestartBeep: Bool?
}

/// An error.
/// Path: `game/{id}/error`
public struct Error: Codable {
  let gameId: Int64  // game_id
  let error: String
}

/// Contains game data for the indicated game.
/// Path: `game/{id}/gamedata`
public struct GameDataEvent: Codable {
  public let agaHandicapScoring: Bool
  public let allowKo: Bool
  public let allowSelfCapture: Bool
  public let allowSuperko: Bool
  public let autoScore: Bool?
  public let automaticStoneRemoval: Bool
  public let blackPlayerId: Int64
  public let clock: GameClockEvent
  public let conditionalMoves: [Int64: ConditionalMovesSpec]?
  public let disableAnalysis: Bool
  public let freeHandicapPlacement: Bool
  public let gameId: Int64
  public let gameName: String
  public let handicap: Int
  public let height: Int

  //  FIXME:   history: [Any]  // ???
  public let initialPlayer: StoneColor

  public let initialState: [StoneColor: [PointSGF]]
  public let komi: Float
  public let metaGroups: [Int64]  // ???
  public let moves: [MoveSpec]

  public let opponentPlaysFirstAfterResume: Bool
  public let originalDisableAnalysis: Bool
  public let pauseControl: PauseControl?

  // TODO:   pausesLeft<PlayerId>
  public let pauseOnWeekends: Bool

  public let phase: Phase
  public let players: [StoneColor: Player]
  public let `private`: Bool
  public let ranked: Bool
  public let rules: Ruleset
  public let scoreHandicap: Bool
  public let scorePasses: Bool
  public let scorePrisoners: Bool
  public let scoreStones: Bool
  public let scoreTerritory: Bool
  public let scoreTerritoryInSeki: Bool
  public let startTime: Int64
  public let strictSekiMode: Bool
  public let superkoAlgorithm: SuperkoAlgorithm
  public let timeControl: TimeControl
  public let whiteMustPassLast: Bool
  public let whitePlayerId: Int64
  public let width: Int

  /// A conditional move.
  public struct ConditionalMovesSpec: Codable {
    public let moveNumber: Int64
    public let moves: [ConditionalMovesDict?]
  }
}

// Indicates a move or pause.
// Path: `game/{id}/clock`
public struct GameClockEvent: Codable {
  public let blackPlayerId: Int64
  public let blackTime: TimeSystemOrInt
  public let currentPlayer: Int64
  public let expiration: Int64
  public let expirationDelta: Int64?
  public let gameId: Int64
  public let lastMove: Int64
  public let now: Int64
  public let pause: Pause?
  public let pauseDelta: Int64?
  public let pausedSince: Int64
  public let startMode: Bool?
  public let title: String
  public let whitePlayerId: Int64
  public let whiteTime: TimeSystemOrInt

  public struct Pause: Codable {
    public let pauseControl: PauseControl
    public let paused: Bool
    public let pausedSince: Int64
  }
}

// MARK: - types

/// A stone color.
public enum StoneColor: String, Codable {
  case black
  case white
}

/// A point on the Go board in [Smart Game Format](https://en.wikipedia.org/wiki/Smart_Game_Format) notation.
/// The origin is the top left of the board.
public struct PointSGF: Codable & Hashable {
  private let val: String
}

/// A point on the Go board as a zero-based (x, y) coordinate.
/// The origin is the top left of the board.
public struct PointXY: Codable {
  private let x,y: Int
}

/// A tuple of move and duration.
public struct MoveSpec: Codable {
  public let point: PointXY
  public let duration: Int64  // millis
}

/// A move conditioned upon an opponents move.
public struct ConditionalMove: Codable {
  public let move: PointSGF
  public let response: Response

  public struct Response: Codable {
    public let move: PointSGF
    public let next: ConditionalMovesDict
  }
}

/// The conditional moves registered for each player.
public typealias ConditionalMovesDict = [PointSGF: [ConditionalMove]]

/// The game speed.
public enum Speed: String, Codable {
  case blitz
  case normal
  case correspondence
}

/// The game ruleset.
public enum Ruleset: String, Codable {
  case aga
  case chinese
  case ing
  case japanese
  case korean
  case nz
}

/// The game superko algorithm.
public enum SuperkoAlgorithm: String, Codable {
  case ssk
}

/// The game phase.
public enum Phase: String, Codable {
  case play
  case stoneRemoval
  case finished
}

/// The game result.
public enum Outcome: String, Codable {
  case abandoned
  case cancelled
  case disconnected
  case disqualified
  case moderated
  case resigned
  case timeout
}

/// A pause control.
public struct PauseControl: Codable {
  public let stoneRemoval: Bool
}

/// A time control.
public struct TimeControl: Codable {
  public let system: TimeSystem
  public let speed: Speed
  public let timeControl: TimeSystem
  public let pauseOnWeekends: Bool

  public let initialTime: Int64?
  public let mainTime: Int64?
  public let maxTime: Int64?
  public let periods: Int64?
  public let periodTime: Int64?
  public let perMove: Int64?
  public let stonesPerPeriod: Int64?
  public let timeIncrement: Int64?
  public let totalTime: Int64?
}

/// The game time system.
public enum TimeSystem: String, Codable {
  case fischer
  case byoyomi
  case simple
  case canadian
  case absolute
  case none
}

/// A game time system in detail.
public struct TimeSystemSpec: Codable {
  public let blockTime: Int64?
  public let movesLeft: Int64?
  public let periodTime: Int64?
  public let periods: Int64?
  public let skipBonus: Bool?
  public let system: TimeSystem
  public let thinkingTime: Int64?

}

/// Either a time system spec or an int value.
public enum TimeSystemOrInt: Codable {
  case system(TimeSystemSpec)
  case int(Int64)

  public init(from decoder: Decoder) throws {
    let values = try decoder.singleValueContainer()
    if let val = try? values.decode(Int64.self) {
      self = .int(val)
      return
    }
    throw DecodingError.dataCorruptedError(
      in: values, debugDescription: "not implemented; found \(dump(values))")
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    switch self {
    case let .system(val):
      try container.encode(val)
    case let .int(val):
      try container.encode(val)
    }
  }
}
