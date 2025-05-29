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
    
    @State private var selectedGameMode: pointsInGame = .bo1
    
    @State private var team1Score = 0
    @State private var team2Score = 0
    
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
            DatePicker("Fecha del partido", selection: $newMatch.matchDate, displayedComponents: .date)
                .datePickerStyle(.compact)
            
            
            
            Section(header: Text("text.game_mode")) {
                Picker("info.pointsInGame", selection: $newMatch.pointType) {
                    ForEach(pointsInGame.allCases) { game in
                        Text(game.rawValue).tag(game)
                    }
                }.pickerStyle(.palette)
                    .labelsHidden()
            }
            
            if newMatch.games.count > 0 {
                Section(header: Text("text.game_mode")) {
                    HStack(spacing:20) {
                        ForEach(newMatch.games, id: \.self) { game in
                            HStack{
                                Text("\(game.team1) - \(game.team2)")
                                    .foregroundStyle( (game.team1>game.team2) ? .green : .red)
                                    .font(.system(size: 40, weight: .bold))
                            }
                        }
                    }
                    
                }
            }
        }
        if newMatch.games.count < newMatch.pointType.numberOfGames {
            VStack {
                HStack {
                    Picker("Team 1", selection: $team1Score) {
                        ForEach(scoreOptions, id: \.self) { score in
                            Text("\(score)")
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(maxWidth: .infinity)
                    
                    Picker("Team 2", selection: $team2Score) {
                        ForEach(scoreOptions, id: \.self) { score in
                            Text("\(score)")
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(maxWidth: .infinity)
                }.frame(height: 80)
                Button("Añadir Set") {
                    let newGame = GameScore(team1: team1Score, team2: team2Score)
                    newMatch.games.append(newGame)
                    team1Score = 0
                    team2Score = 0
                }
            }.padding()
        }
        Button("Guardar partido (en desarrollo)") {
            
            context.insert(newMatch)
            try? context.save()
            print(">>>>>Nuevo match creado: \(newMatch)")
            dismiss()
        }
    }
}

#Preview {
    CreateMatchData(newMatch: .constant(MatchData()))
}
