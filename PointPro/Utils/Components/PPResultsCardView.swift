//
//  PPResultsCardView.swift
//  PointPro
//
//  Created by Carlos Suarez on 4/6/25.
//

import SwiftUI

struct PPResultsCardView: View {
    var match : MatchData

    private let adaptiveColumns =  [
        GridItem(.adaptive(minimum: 90))
    ]
    var body: some View {
        
        LazyVGrid(columns:adaptiveColumns,spacing: 0){
            ForEach(Array(match.games.enumerated()), id: \.element) { index, game in
                PPResult(pTeam1: game.team1,
                         pTeam2: game.team2,
                         number: index)
            }

        }.padding(15)
    }
}

#Preview {
    PPResultsCardView(match: MatchData(id: UUID(),
                                       teammates: "",
                                       date: Date(),
                                       location: "",
                                       games: [(GameScore(team1: 6, team2: 0)),
                                               (GameScore(team1: 2, team2: 6)),
                                               (GameScore(team1: 6, team2: 5)),
                                               (GameScore(team1: 6, team2: 5)),
                                               (GameScore(team1: 6, team2: 5))],
                                       pointType: .bo3,
                                       isOpenSet: false,
                                       position: .right))
}
