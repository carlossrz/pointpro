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
                    
                    HStack(spacing: 20) {
                        PPSectionCard(title: "Wins when serving first".localizedValue) {
                            ProgressRingView(actual: vm.wonMatchesWhenOpening,
                                             total: vm.totalMatchesWhenOpening,
                                             size: 120)
                            .padding(.horizontal)
                        }
                        
                        PPSectionCard(title: "Wins when receiving first".localizedValue) {
                            ProgressRingView(actual: vm.wonMatchesWhenReceiving,
                                             total: vm.totalMatchesWhenReceiving,
                                             size: 120)
                            .padding(.horizontal)
                            
                        }
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
    // Parámetros:
    // Solo uno de estos modos se usará.
    var progress: Double? = nil
    var actual: Int? = nil
    var total: Int? = nil
    
    // Tamaño del círculo (ancho y alto)
    var size: CGFloat = 200
    
    // Calcula el progreso de 0 a 1 según los datos dados
    private var computedProgress: Double {
        if let progress = progress {
            return min(max(progress, 0), 1)
        }
        if let actual = actual, let total = total, total > 0 {
            return Double(actual) / Double(total)
        }
        return 0
    }
    
    // Texto a mostrar según el modo:
    // - Si `progress` está definido y `actual`/`total` no, mostramos %.
    // - Si `actual` y `total` están definidos, mostramos fracción `actual/total`.
    private var progressText: String {
        if let progress = progress, (actual == nil || total == nil) {
            let percent = Int(min(max(progress, 0), 1) * 100)
            return "\(percent)%"
        }
        if let actual = actual, let total = total, total > 0 {
            return "\(actual)/\(total)"
        }
        return ""
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.ppBlue.opacity(0.5), lineWidth: size * 0.04)
            
            Circle()
                .trim(from: 0, to: computedProgress)
                .stroke(
                    Color.ppGreenBall,
                    style: StrokeStyle(lineWidth: size * 0.04, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut(duration: 0.8), value: computedProgress)
            
            Text(progressText)
                .font(.system(size: size * 0.15, weight: .bold, design: .rounded))
                .foregroundColor(.ppBlue)
        }
        .frame(width: size, height: size)
    }
}







