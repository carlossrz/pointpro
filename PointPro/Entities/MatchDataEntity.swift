//
//  MatchDataEntity.swift
//  PointPro
//
//  Created by Carlos Suarez on 24/4/25.
//

import Foundation
import SwiftUI

enum pointsInGame: String, CaseIterable, Identifiable, Codable {
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

struct MatchData: Codable {
    let id: UUID
    let teammates: String
    let date: String
    var games: [GameScore]
    let isWinner: Bool
    var pointType: pointsInGame
    
    init(id: UUID, teammates: String, date: String, games: [GameScore], isWinner: Bool, pointType: pointsInGame) {
        self.id = id
        self.teammates = teammates
        self.date = date
        self.games = games
        self.isWinner = isWinner
        self.pointType = pointType
    }
    
    init() {
        self.id = UUID()
        self.teammates = ""
        self.date = Date().description
        self.games = []
        self.isWinner = false
        self.pointType = .bo1
    }
}

struct GameScore: Codable {
    let team1: Int
    let team2: Int
}


