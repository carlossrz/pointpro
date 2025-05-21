//
//  PPMatchCell.swift
//  PointPro
//
//  Created by Carlos Suarez on 20/5/25.
//

import SwiftUI

struct PPMatchCell: View {
    var matchData = MatchData()
    
    var body: some View {
        HStack {
            VStack {
                Text(matchData.finalScore)
                    .font(.system(size: 25, weight: .bold, design: .default))
                    .foregroundStyle(matchData.isWinner ? .green : .red)
                Text(matchData.date)
                    .font(.system(size: 10, weight: .light, design: .default))
            }
            Divider()
            VStack(alignment: .leading) {
                Text("text.teammate")
                    .font(.system(size: 10, weight: .light, design: .default))
                Text(matchData.teammates.isEmpty ? "add.details" : matchData.teammates)
                    .font(.system(size: 20, weight: .light, design: .default))
            }
            Spacer()
            Circle()
                .fill(Color.red)
                .frame(width:20)
                .opacity(0.8)
                .shadow(color: .gray, radius: 2, x: 1, y: 1)
        }
    }
}

#Preview {
    PPMatchCell(matchData: MatchData(id: UUID(),
                                     teammates: "Antony Davids",
                                     date: "20/10/2024",
                                     games: [(GameScore(team1: 6, team2: 0)),
                                             (GameScore(team1: 2, team2: 6)),
                                             (GameScore(team1: 6, team2: 5))],
                                     pointType: .bo3))
    .padding()
}
