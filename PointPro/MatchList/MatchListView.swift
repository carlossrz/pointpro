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
    
    @StateObject var vm = MatchListViewModel()
    @State var showCreate: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(matches){ match in
                    PPMatchCell(matchData: match)
                        .swipeActions {
                            Button(role: .destructive) {
                                withAnimation {
                                    context.delete(match)
                                    try? context.save()
                                }
                            } label: {
                                Label("key.delete", systemImage: "trash")
                                    .symbolVariant(.fill)
                            }
                        }
                }
            }
            .toolbar{
                ToolbarItem(placement: .primaryAction, content: {
                    Button{
                        showCreate.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                })
            }.sheet(isPresented: $showCreate) {
                NavigationStack {
                    CreateMatchData(newMatch: .constant(MatchData()))
                    //MatchDetailView(habit: .constant(nil))
                }
                .presentationDragIndicator(.visible)
            }
        }.navigationTitle("text.matchList")
    }
}

#Preview {
    MatchListView()
}
