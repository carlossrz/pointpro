//
//  InfoMacthviEW.swift
//  PointWatch Watch App
//
//  Created by Carlos Suarez on 6/5/25.
//

import SwiftUI

struct StartMatchView: View {
    
    @State var isStart: Bool = false
    @State var shouldNavigate = false
    @State var matchData = MatchData()
    
    var body: some View {
        
        NavigationStack{
            if isStart {
                VStack(alignment:.leading, spacing:4) {
                    Text("info.match.title")
                    Picker("info.pointsInGame", selection: $matchData.pointType) {
                        ForEach(MatchFormat.allCases) { game in
                            Text(game.rawValue).tag(game)
                        }
                    }
                    .frame(height: 70)
                    .padding(.horizontal, 10)
                    .tint(.red)
                    Toggle("info.openset",isOn: $matchData.isOpenSet)
                        .padding(.horizontal,10)
                        .tint(Color.ppGreenBall)
                    
                   PPButtonSlider {
                       shouldNavigate.toggle()
                    }
                }.navigationBarBackButtonHidden(true)
                 .navigationDestination(isPresented: $shouldNavigate) {
                        ScoreBoardView(matchData: matchData) {
                                withAnimation(.easeInOut) {
                                    isStart = false
                                    matchData = MatchData()
                                }
                            }
                    }
            } else {
                Button {
                    withAnimation(.bouncy(duration: 0.5)) {
                        isStart.toggle()
                    }
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.ppGreenBall)
                            .frame(width: 150, height: 150)
                            .opacity(0.8)
                            .shadow(color: .gray, radius: 2, x: 1, y: 1)
                        
                        Text("text.configureMatch")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                    }
                }.buttonStyle(.plain)
            }
        }
    }
}


#Preview {
    StartMatchView()
}
