//
//  StadisticsView.swift
//  PointPro
//
//  Created by Carlos Suarez on 17/6/25.
//

import SwiftUI
import SwiftData

struct StadisticsView: View {
    @Query(sort: \MatchData.date,order: .reverse) private var matches: [MatchData]
    @StateObject private var vm: StatisticsViewModel
    
    init() {
        _vm = StateObject(wrappedValue: StatisticsViewModel(matches: []))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.gray.opacity(0.4).ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading,spacing:10) {
                    Text("text.stadistics".localizedValue)
                        .font(.system(size: 30, weight: .bold))
                        .foregroundStyle(.ppBlue)
                    PPSectionCard(title: ""){
                        VStack {
                            ProgressRingView(progress: vm.winPercentage)
                            HStack(spacing: 60) {
                                VStack {
                                    Text("\(vm.wonMatches)")
                                        .font(.system(size: 30, weight: .bold))
                                    Text("text.wins")
                                        .font(.system(size: 10, weight: .light))
                                }.foregroundStyle(.ppBlue)
                                
                                VStack {
                                    Text("\(vm.lostMatches)")
                                        .font(.system(size: 30, weight: .bold))
                                    Text("text.losses")
                                        .font(.system(size: 10, weight: .light))
                                }.foregroundStyle(.ppBlue)
                                
                                VStack {
                                    Text("\(vm.drawMatches)")
                                        .font(.system(size: 30, weight: .bold))
                                    Text("text.draws")
                                        .font(.system(size: 10, weight: .light))
                                }.foregroundStyle(.ppBlue)
                            }.frame(maxWidth: .infinity)
                        }.padding(.vertical)
                    }
                    PPSectionCard(title: "text.performSide".localizedValue){
                        SidePerformanceChart(data: vm.sideStats)
                    }
                    
                }.padding(.top,20)
                    .padding(.horizontal)
            }
        }
        .onAppear {
            vm.updateMatches(with: matches)
        }
        
    }
    
}

#Preview {
    StadisticsView()
}


struct ProgressRingView: View {
    var progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.ppBlue.opacity(0.5), lineWidth: 8)
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(
                    Color.ppGreenBall,style: StrokeStyle(lineWidth: 8, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut(duration: 0.8), value: progress)
            
            VStack(spacing: 4) {
                Text("\(Int(progress * 100))%")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundStyle(.ppBlue)
            }
        }
        .frame(width: 200, height: 180)
    }
}







