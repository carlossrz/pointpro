//
//  ContentView.swift
//  PointPro
//
//  Created by Carlos Suarez on 24/4/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
    var body: some View {
        TabView{
            MatchListView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("text.matchlist")
                }
                //StatsView
        }
    }
}

#Preview {
    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
}
