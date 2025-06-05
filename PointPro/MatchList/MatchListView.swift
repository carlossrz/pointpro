//
//  MatchListView.swift
//  PointPro
//
//  Created by Carlos Suarez on 21/5/25.
//

import SwiftUI
import SwiftData

struct MatchListView: View {
    @Query(sort: \MatchData.date,order: .reverse) private var matches: [MatchData]
    @Environment(\.modelContext) private var context
    
    //@StateObject var vm = MatchListViewModel()
    @State var showCreate: Bool = false
    @State private var matchEdit: MatchData?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(matches){ match in
                    PPMatchCell(matchData: match)
                        .swipeActions {
                            Button(role: .none) {
                                withAnimation {
                                    matchEdit = match
                                }
                            }label: {
                                Label("key.edit", systemImage: "pencil")
                                    .symbolVariant(.fill)
                            }
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
                }
                .presentationDragIndicator(.visible)
            }.sheet(item: $matchEdit) {
                matchEdit = nil
            } content: { item in
                MatchDetailView(match: .constant(item))
                    .presentationDragIndicator(.visible)
            }
        }.navigationTitle("text.matchList")
    }
}


#Preview {
    MatchListView()
}
