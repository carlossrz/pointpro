//
//  MatchDetailView.swift
//  PointPro
//
//  Created by Carlos Suarez on 27/5/25.
//

import SwiftUI
struct MatchDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var match : MatchData
    var body: some View {
        ScrollView{
            VStack(spacing: 16) {
                VStack(spacing: 8) {
                    Text(match.finalScore)
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(match.isWinner ? .ppGreenBall : .red)
                    
                    Text(match.date.shortFormatted)
                        .font(.headline)
                        .foregroundColor(.white)
                }.padding(.top, -110)
                PPSectionCard(title: "text.detailsMacthes".localizedValue) {
                    VStack(alignment: .leading, spacing: 22) {
                        TextField("text.location", text: Binding(
                            get: { match.location ?? "" },
                            set: { match.location = $0 }
                        ))
                        TextField("text.teammate", text: Binding(
                            get: { match.teammates ?? "" },
                            set: { match.teammates = $0 }
                        ))
                        Toggle("info.openset",isOn: $match.isOpenSet)
                            .tint(Color.ppBlue)
                        Picker("text.selectposition", selection: $match.position) {
                            Text("left").tag(PlayerSide.left)
                            Text("right").tag(PlayerSide.right)
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                }
                PPSectionCard(title: "text.results".localizedValue.uppercased()) {
                    PPResultsCardView(match: match)
                }
            }.padding(.top,150)
                .padding(.horizontal)
        }.backgroundGrid(backgroundVersion:.iOS)
    }
}

#Preview {
    MatchDetailView(match: .constant(MatchData(id: UUID(),
                                               teammates: "",
                                               date: Date(),
                                               location: "",
                                               games: [(GameScore(team1: 6, team2: 0)),
                                                       (GameScore(team1: 2, team2: 6)),
                                                       (GameScore(team1: 6, team2: 5))],
                                               pointType: .bo3,
                                               isOpenSet: false ,
                                               position: .right)))
}
