//
//  MatchDetailView.swift
//  PointPro
//
//  Created by Carlos Suarez on 27/5/25.
//

import SwiftUI

// Pantalla destinada a la edicion de informacion del partido, exactamente cuando nos llega la info desde el reloj. aqui se podra complementar la informaicon que no recogemos desde el Apple Watch
struct MatchDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var match : MatchData
    
    var body: some View {
        ZStack {
            Color.ppBlue
                .ignoresSafeArea()
            VStack {
                VStack {
                    Text(match.finalScore)
                        .foregroundStyle( (match.isWinner) ? .ppGreenBall : .red)
                        .font(.system(size: 70, weight: .bold))
                    Text("\(match.date)")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(.white)
                }.padding(.bottom,20)
                Form {
                    Section(header: Text("text.detailsMacthes")) {
                        VStack(alignment: .leading) {
                            TextField("text.location",text: Binding(
                                get: { match.location ?? "" },
                                set: { match.location = $0 }
                            ))
                            
                        }
                        VStack(alignment: .leading) {
                            TextField("text.teammate",text: Binding(
                                get: { match.teammates ?? "" },
                                set: { match.teammates = $0 }
                            ))
                        }
                    }
                    Section(header: Text("text.results")) {
                        PPResultsCardView(match: match)
                    }.padding(-10)
                }
            }.padding(.top,30)
            
        }
        
        
    }
}

#Preview {
    MatchDetailView(match: .constant(MatchData(id: UUID(),
                                               teammates: "",
                                               date: "20/10/2024",
                                               location: "",
                                               games: [(GameScore(team1: 6, team2: 0)),
                                                       (GameScore(team1: 2, team2: 6)),
                                                       (GameScore(team1: 6, team2: 5))],
                                               pointType: .bo3,
                                               position: .right)))
}
