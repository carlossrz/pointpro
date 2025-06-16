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
        ZStack {
            Color.ppBlue
                .cornerRadius(20)
                .frame(height: 100)
                .shadow(radius: 5)
            
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(matchData.teammates ?? "add.details")")
                        .font(.headline)
                        .foregroundColor(.ppGreenBall)
                    
                    Text("\(matchData.location ?? "")")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                    
                    HStack(spacing:10) {
                        Text("\(matchData.date.shortFormatted)")
                            .foregroundColor(.white)
                            .font(.caption)
                        HStack(spacing:2) {
                            Image(systemName: "figure.racquetball")
                            Text("\(matchData.position.localized)")
                        }.foregroundColor(.ppGreenBall)
                            .font(.caption)
                    }
                }
                
                Spacer()
                
                if ((matchData.teammates ?? "").isEmpty ||
                    (matchData.location ?? "").isEmpty ) {
                    Circle()
                        .fill(Color.red)
                        .frame(width:10)
                        .opacity(0.8)
                        .shadow(color: .gray, radius: 2, x: 1, y: 1)
                }
                VStack {
                    Text("\(matchData.finalScore)")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .bold()
                        .foregroundColor(.white)
                    Text("\(matchData.pointType.rawValue)")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            .padding(.horizontal)
        }
        
    }
}

#Preview {
    PPMatchCell(matchData: MatchData(id: UUID(),
                                     teammates: "Glenda",
                                     date: Date(),
                                     location: "Las Torres",
                                     games: [(GameScore(team1: 6, team2: 0)),
                                             (GameScore(team1: 2, team2: 6)),
                                             (GameScore(team1: 6, team2: 5))],
                                     pointType: .bo3,
                                     isOpenSet: false,
                                     position: .right))
    .padding()
}
