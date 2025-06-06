//
//  PointProApp.swift
//  PointPro
//
//  Created by Carlos Suarez on 24/4/25.
//

import SwiftUI
import SwiftData

@main
struct PointProApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([MatchData.self, GameScore.self])
        let config = ModelConfiguration("PointProBBDD", schema: schema, isStoredInMemoryOnly: false)
        return try! ModelContainer(for: schema, configurations: [config])
    }()

    init() {
        CRUDDataService.shared.configure(sharedModelContainer.mainContext)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}

