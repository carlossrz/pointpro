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
    
    @State private var expanded = false
    
    let screenSize = WKInterfaceDevice.current().screenBounds.size
    
    var body: some View {
        ZStack {
            if isStart {
                InfoMatchData
            } else {
                ZStack {
                    Circle()
                        .fill(Color.ppGreenBall)
                        .frame(width: 150, height: 150)
                        .scaleEffect(expanded ? screenSize.height / 150 * 2 : 1)
                        .shadow(color: .gray, radius: 2, x: 1, y: 1)
                        .overlay(
                            Text("text.configureMatch")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .opacity(expanded ? 0 : 1)
                        )
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.6)) {
                                expanded = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                isStart = true
                            }
                        }
                }
                .frame(width: screenSize.width, height: screenSize.height)
                .backgroundGrid()
            }
        }
        .frame(width: screenSize.width, height: screenSize.height)
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    var InfoMatchData: some View {
        NavigationStack {
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
                            expanded = false
                            matchData = MatchData()
                        }
                    }
                }
                .padding(.top,-15)
        }
    }
}


#Preview {
    StartMatchView()
}
