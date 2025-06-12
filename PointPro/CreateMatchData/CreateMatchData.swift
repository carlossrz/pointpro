//
//  CreateMatchData.swift
//  PointPro
//
//  Created by Carlos Suarez on 28/5/25.
//

import SwiftUI

struct CreateMatchData: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @Binding var newMatch : MatchData
    
    @State private var selectedGameMode: MatchFormat = .bo1
    
    @State private var team1Score = 0
    @State private var team2Score = 0
    
    @State private var isPresented: Bool = false
    
    let scoreOptions = Array(0...7)
    
    var body: some View {
        Form {
            TextField("text.location",text: Binding(
                get: { newMatch.location ?? "" },
                set: { newMatch.location = $0 }
            ))
            TextField("text.teammate",text: Binding(
                get: { newMatch.teammates ?? "" },
                set: { newMatch.teammates = $0 }
            ))
            Picker("text.selectposition", selection: $newMatch.position) {
                Text("left").tag(PlayerSide.left)
                Text("right").tag(PlayerSide.right)
            }
            DatePicker("text.date", selection: $newMatch.date, displayedComponents: .date)
                .datePickerStyle(.compact)
            
            
            Section(header: Text("text.game_mode")) {
                Picker("info.pointsInGame", selection: $newMatch.pointType) {
                    ForEach(MatchFormat.allCases) { game in
                        Text(game.rawValue).tag(game)
                    }
                }.pickerStyle(.palette)
                    .padding()
                
                if newMatch.games.count < newMatch.pointType.numberOfGames {
                    VStack {
                        VStack {
                            Picker("Team 1", selection: $team1Score) {
                                ForEach(scoreOptions, id: \.self) { score in
                                    Text("\(score)")
                                }
                            }
                            .pickerStyle(.segmented)
                            .frame(maxWidth: .infinity)
                            
                            Picker("Team 2", selection: $team2Score) {
                                ForEach(scoreOptions, id: \.self) { score in
                                    Text("\(score)")
                                }
                            }
                            .pickerStyle(.segmented)
                            .frame(maxWidth: .infinity)
                        }.frame(height: 80)
                        Button("text.addset") {
                            let newGame = GameScore(team1: team1Score, team2: team2Score)
                            newMatch.games.append(newGame)
                            team1Score = 0
                            team2Score = 0
                        }
                    }.padding()
                }
                if newMatch.games.count > 0 {
                        PPResultsCardView(match: newMatch)
                }
            }
        }
        
        PPButtonSlider(text:"save.match") {
            if ((newMatch.teammates?.isEmpty) != nil) || ((newMatch.location?.isEmpty) != nil) {
                context.insert(newMatch)
                try? context.save()
                dismiss()
            } else {
                isPresented.toggle()
            }
        }
        .alert("key.attention",
                isPresented: $isPresented,
                actions: {
            Button("OK") {}},
                message: {
            Text("text.completedFields")
        })
        .frame(height: 60)
        .padding(.bottom,10)
    }
}

#Preview {
    CreateMatchData(newMatch: .constant(MatchData()))
}
