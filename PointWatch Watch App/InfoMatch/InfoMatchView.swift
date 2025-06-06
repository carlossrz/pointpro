//
//  InfoMacthviEW.swift
//  PointWatch Watch App
//
//  Created by Carlos Suarez on 6/5/25.
//

import SwiftUI



struct InfoMatchView: View {
    
    @State var selectedTheme: Bool = false
    @State var shouldNavigate = false
    
    @State var matchData = MatchData()
    @State var isOpenSet: Bool = false
    
    @State private var selectedGameMode: MatchFormat = .bo1
    
    var body: some View {
        NavigationStack{
            VStack(alignment:.leading, spacing:4) {
                Text("info.match.title")
                Picker("info.pointsInGame", selection: $selectedGameMode) {
                    ForEach(MatchFormat.allCases) { game in
                        Text(game.rawValue).tag(game)
                    }
                }
                .frame(height: 70)
                .padding(.horizontal, 10)
                .tint(.red)
                Toggle("info.openset",isOn: $isOpenSet)
                    .padding(.horizontal,10)
                    .tint(Color.ppGreenBall)
                
                PPButtonSlider {
                    matchData.pointType = selectedGameMode
                    shouldNavigate = true
                }
            }
            // esta info se pasara para posicionar la pelota del marcador en la siguiente pantalla ( añadiremos la logica de esa pelota segun tenga esta informacion en al pantalla)
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $shouldNavigate) {
            ScoreBoardView(
                isOpenSet: isOpenSet,
                matchData: matchData)
        }
    }
}


#Preview {
    InfoMatchView()
}
