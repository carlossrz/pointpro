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
        }
    }
}

//#Preview {
//    ContentView()
////        .modelContainer(for: Item.self, inMemory: true)
//}
