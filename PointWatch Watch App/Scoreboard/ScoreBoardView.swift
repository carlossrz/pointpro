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
    
    var body: some View {
        VStack{
            HStack {
                PPScoreBoard(isOpenSet: vm.isOpenSet,
                             globalPointsMatch: vm.matchData.games, liveGameScores: vm.liveGameScores)
                Spacer()
            }
            HStack(spacing:10){
                PPButton(points: vm.pointA) {
                    vm.team = 1
                    vm.sumPoint()
                }
                Text("-")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
                PPButton(points: vm.pointB){
                    vm.team = 2
                    vm.sumPoint()
                }
            }
            Button {
                vm.restPoint()
            } label: {
                Image(systemName: "arrow.counterclockwise")
                    .foregroundColor(.red)
            }.buttonStyle(.plain)
            
            //            Button {
            //
            //            } label: {
            //                Text("Finalizar partido")
            //
            //            }
        }.padding()
            .onAppear(perform: {
                vm.matchData = matchData
                if isOpenSet{
                    vm.isOpenSet = true
                }
            })
            .onChange(of: vm.shouldDismiss) { newValue in
                if newValue {
                    dismiss()
                }
            }
    }
}

#Preview {
    ScoreBoardView(isOpenSet: false)
}
