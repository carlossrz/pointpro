//
//  BackgroundModifier.swift
//  PointPro
//
//  Created by Carlos Suarez on 10/6/25.
//
import SwiftUI

struct BackgroundModifier: ViewModifier {
    var color: Color = .ppBlue

    func body(content: Content) -> some View {
        ZStack {
            color
                .ignoresSafeArea()

            Rectangle()
                .frame(width: 3, height: 300)
                .foregroundColor(.white)

            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 3)
                .padding(.bottom, 170)
                .foregroundColor(.white)

            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 3)
                .padding(.top, 170)
                .foregroundColor(.white)

            content
        }
    }
}
