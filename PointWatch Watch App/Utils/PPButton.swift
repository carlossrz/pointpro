//
//  PPButton.swift
//  PointWatch Watch App
//
//  Created by Carlos Suarez on 30/4/25.
//

import SwiftUI

struct PPButton: View {
    var points: String
    var action: () -> Void
    
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Circle()
                    .fill(Color.ppGreenBall)
                    .frame(width: 70, height: 70)
                    .opacity(0.8)
                    .shadow(color: .gray, radius: 2, x: 1, y: 1)

                Text(points)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
            }
        }.buttonStyle(.plain) 

    }
}

#Preview {
    PPButton(points: "15"){}
}
