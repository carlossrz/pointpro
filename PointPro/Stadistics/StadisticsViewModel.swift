//
//  StadisticsViewModel.swift
//  PointPro
//
//  Created by Carlos Suarez on 17/6/25.
//


import SwiftUI
import Combine

final class StatisticsViewModel: ObservableObject {
    @Published var matches: [MatchData] = []
    
    var lastThreeMatches: [MatchData] {
        Array(matches.prefix(3))
    }
    
    var totalMatches: Int {
        matches.count
    }
    
    var wonMatches: Int {
        matches.filter { $0.isWinner }.count
    }
    
    var lostMatches: Int {
        matches.filter { !$0.isWinner && $0.team1Wins != $0.team2Wins }.count
    }
    
    var drawMatches: Int {
        matches.filter { $0.team1Wins == $0.team2Wins }.count
    }
    
    var winPercentage: Double {
        guard totalMatches > 0 else { return 0 }
        return Double(wonMatches) / Double(totalMatches)
    }
    
    var leftMatchesWin: Int{
        matches.filter { $0.isWinner && $0.position == .left }.count
    }
    var leftMatchesLost: Int{
        matches.filter { !$0.isWinner && $0.position == .left }.count
    }
    
    var rightMatchesWin: Int{
        matches.filter { $0.isWinner && $0.position == .right }.count
    }
    var rightMatchesLost: Int{
        matches.filter { !$0.isWinner && $0.position == .right }.count
    }
    //Cuando abres el partido
    var wonMatchesWhenOpening: Int {
        matches.filter { $0.isWinner && $0.isOpenSet }.count
    }
    var totalMatchesWhenOpening: Int {
        matches.filter { $0.isOpenSet }.count
    }
    // Cuando recibes
    var wonMatchesWhenReceiving: Int {
        matches.filter { $0.isWinner && !$0.isOpenSet }.count
    }
    var totalMatchesWhenReceiving: Int {
        matches.filter { !$0.isOpenSet }.count
    }
    var sideStats: [PositionStat] {
        [
            .init(side: "left".localizedValue, result: "text.wins".localizedValue, count: leftMatchesWin),
            .init(side: "left".localizedValue, result: "text.losses".localizedValue, count: leftMatchesLost),
            .init(side: "right".localizedValue, result: "text.wins".localizedValue,  count: rightMatchesWin),
            .init(side: "right".localizedValue, result: "text.losses".localizedValue, count: rightMatchesLost),
        ]
    }
    
    init(matches: [MatchData] = []) {
        self.matches = matches
    }
    
    func updateMatches(with newMatches: [MatchData]) {
        self.matches = newMatches
    }
    
}
