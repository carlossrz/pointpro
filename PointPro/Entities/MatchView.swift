//
//  MatchView.swift
//  PointPro
//
//  Created by Carlos Suarez on 28/4/25.
//

import SwiftUI

struct MatchView: View {
    var body: some View {
        VStack{
            List{
                Text("Partido 1")
                Text("Partido 2")
                Text("Partido 3")
            }.navigationTitle("Lista de partidos:")
             .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

#Preview {
    MatchView()
}
