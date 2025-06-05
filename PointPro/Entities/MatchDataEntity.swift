//
//  MatchDataEntity.swift
//  PointPro
//
//  Created by Carlos Suarez on 24/4/25.
//

import Foundation
import SwiftUI
import SwiftData

enum MatchFormat: String, CaseIterable, Identifiable, Codable {
    case bo1 = "Best of One"
    case bo3 = "Best of Three"
    case bo5 = "Best of Five"
    
    var id: String { self.rawValue }
    
    var numberOfGames: Int {
        switch self {
        case .bo1:
            return 1
        case .bo3:
            return 3
        case .bo5:
            return 5
        }
    }
}

enum PlayerSide: String, Codable {
    case left
    case right
}

@Model
class MatchData {
    @Attribute(.unique) var id: UUID
    var teammates: String?
    var date: Date
    var location: String?
    var games: [GameScore]
    var pointType: MatchFormat
    var position: PlayerSide
    
    
    var finalScore: String {
        "\(team1Wins)-\(team2Wins)"
    }
    var isWinner: Bool {
        team1Wins > team2Wins
    }
    
    private var team1Wins: Int {
        games.filter { $0.team1 > $0.team2 }.count
    }
    private var team2Wins: Int {
        games.filter { $0.team2 > $0.team1 }.count
    }
    
    init(id: UUID, teammates: String, date: Date, location: String, games: [GameScore], pointType: MatchFormat, position: PlayerSide) {
        self.id = id
        self.teammates = teammates
        self.location = location
        self.date = date
        self.games = games
        self.pointType = pointType
        self.position = .right
    }
    
    init() {
        self.id = UUID()
        self.date = Date()
        self.games = []
        self.pointType = .bo1
        self.position = .right
    }
}

@Model
class GameScore: Hashable {
    @Attribute(.unique) var id: UUID
    var team1: Int
    var team2: Int
    
    init(team1: Int, team2: Int) {
        self.id = UUID()
        self.team1 = team1
        self.team2 = team2
    }
}


