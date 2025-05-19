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
    @Query private var items: [Item]
    
    @State var pointA = "0"
    @State var pointB = "0"
    
    let pointsMatch = ["0", "15", "30", "40","ADV"]
    
    var body: some View {
        
        HStack{
            Button {
                //pointA = vm.addPoints(pointA)
            } label: {
                Text(pointA)
            }
            Button {
                
            } label: {
                Text(pointB)
            }
        }
    }
    
    
    func addPoints(_ points: String)  {
        let point = pointsMatch.firstIndex(of: points) ?? 0
        print(point)
    }
    
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
