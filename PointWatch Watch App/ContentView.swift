//
//  ContentView.swift
//  PointWatch Watch App
//
//  Created by Carlos Suarez on 28/4/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var isOpenSet: Bool = false
    var body: some View {
        NavigationStack {
            NavigationLink(
                destination: InfoMatchView(),
                label: {
                    ZStack {
                        Circle()
                            .fill(Color.ppGreenBall)
                            .frame(width: 150, height: 150)
                            .opacity(0.8)
                            .shadow(color: .gray, radius: 2, x: 1, y: 1)
                        
                        Text("text.configureMatch")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                    }
                }).buttonStyle(.plain)
        }
    }
}

#Preview {
    ContentView()
}
