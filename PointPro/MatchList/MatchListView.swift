//
//  MatchListView.swift
//  PointPro
//
//  Created by Carlos Suarez on 21/5/25.
//

import SwiftUI
import SwiftData

struct MatchListView: View {
    @Query private var matches: [MatchData]
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationStack {
            List {
//                ForEach(matches){ match in
//                    PPMatchCell(matchData: match)
//                }
            }
        }.navigationTitle("text.matchList")
    }
}

#Preview {
    MatchListView()
}
