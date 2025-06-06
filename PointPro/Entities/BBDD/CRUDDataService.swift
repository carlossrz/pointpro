//
//  CRUDDataService.swift
//  PointPro
//
//  Created by Carlos Suarez on 6/6/25.
//

import Foundation
import SwiftData

@MainActor
final class CRUDDataService {
    static let shared = CRUDDataService()
    var modelContext: ModelContext?

    func configure(_ ctx: ModelContext) {
        self.modelContext = ctx
    }

    func saveMatch(_ match: MatchData) {
        guard let ctx = modelContext else { return }
        ctx.insert(match)
        try? ctx.save()
    }

    func updateMatch(_ match: MatchData) {
        guard let ctx = modelContext else { return }
        // Como match está en ctx, cualquier cambio es automático
        try? ctx.save()
    }

    func deleteMatch(_ match: MatchData) {
        guard let ctx = modelContext else { return }
        ctx.delete(match)
        try? ctx.save()
    }
}
