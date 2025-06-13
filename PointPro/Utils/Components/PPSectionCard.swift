//
//  PPSectionCard.swift
//  PointPro
//
//  Created by Carlos Suarez on 13/6/25.
//

import SwiftUI

struct PPSectionCard<Content: View>: View {
    let title: String
    let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.caption)
                .foregroundColor(.ppBlue)
            content()
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 4)
    }
}

#Preview {
    PPSectionCard(title: "Estadísticas") {
        VStack(alignment: .leading) {
            Text("Ganados: 10")
            Text("Perdidos: 2")
        }
    }
}
