//
//  Item.swift
//  PointPro
//
//  Created by Carlos Suarez on 24/4/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
