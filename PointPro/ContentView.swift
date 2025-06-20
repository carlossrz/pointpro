//
//  ContentView.swift
//  PointPro
//
//  Created by Carlos Suarez on 24/4/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var matches: [MatchData]
    var body: some View {
        TabView{
            MatchListView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("text.matchlist")
                }
            StadisticsView()
                .tabItem {
                    Image(systemName: "chart.bar.xaxis")
                    Text("text.stadistics")
                }
            Text("Settings  1.Changes color 2.Nuevas pistas")
                .tabItem {
                    Image(systemName: "gear")
                    Text("text.settings")
                }
        }
    }
}

//#Preview {
//    ContentView()
////        .modelContainer(for: Item.self, inMemory: true)
//}
