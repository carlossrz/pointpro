//
//  ScoreBoardView.swift
//  PointWatch Watch App
//
//  Created by Carlos Suarez on 30/4/25.
//

import SwiftUI

struct ScoreBoardView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = ScoreboardViewModel()
    
    @State var isOpenSet: Bool
    var matchData = MatchData()
    let sessionManager = WatchSessionManager()
    
    var body: some View {
        ZStack {
            background
            TabView {
                ScoreBoardView
                SettingsView
            }.tabViewStyle(.carousel)
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            vm.restPoint()
                        } label: {
                            Image(systemName:"arrow.counterclockwise")
                                .foregroundStyle(.red)
                        }
                    }
                }.padding(.top,-25)
        }
        
    }
    
    @ViewBuilder
    var background: some View {
        Color.ppBlue
            .ignoresSafeArea()
        Rectangle()
            .frame(width: 3, height: 300)
        Rectangle()
            .frame(width: .infinity, height: 3)
            .padding(.bottom, 170)
        Rectangle()
            .frame(width: .infinity, height: 3)
            .padding(.top, 150)
    }
    
    @ViewBuilder
    var SettingsView: some View {
        PPButton(text: "finish.match",color:.ppGreenBall){
#if targetEnvironment(simulator)
            sessionManager.sendMessageMatchResult(match:vm.matchData)
#else
            sessionManager.sendMatchResult(match:vm.matchData)
#endif
            
            vm.shouldDismiss = true
        }.padding(.horizontal)
    }
    
    @ViewBuilder
    var ScoreBoardView: some View {
        VStack(spacing:20){
            HStack{
                PPScoreBoard(isOpenSet: vm.isOpenSet,
                             globalPointsMatch: vm.matchData.games, liveGameScores: vm.liveGameScores)
                Spacer()
                
            }
            PointsButtons
        }.padding()
            .onAppear(perform: {
                vm.matchData = matchData
                if isOpenSet{
                    vm.isOpenSet = true
                }
            })
            .onChange(of: vm.shouldDismiss) { newValue in
                if newValue {
                    vm.clearData()
                    vm.resetPoints()
                    vm.matchData = MatchData()
                    dismiss()
                }
            }
    }
    
    @ViewBuilder
    var PointsButtons: some View {
        HStack(spacing:30){
            PPCircleButton(points: vm.pointA) {
                vm.team = 1
                vm.sumPoint()
            }
            //            Text("-")
            //                .font(.system(size: 30, weight: .bold))
            //                .foregroundColor(.white)
            PPCircleButton(points: vm.pointB){
                vm.team = 2
                vm.sumPoint()
            }
        }
    }
}

#Preview {
    ScoreBoardView(isOpenSet: false)
}
