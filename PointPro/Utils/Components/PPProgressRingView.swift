//
//  PPProgressRingView.swift
//  PointPro
//
//  Created by Carlos Suarez on 24/6/25.
//

import SwiftUI

struct PPProgressRingView: View {
    var progress: Double? = nil
    var actual: Int? = nil
    var total: Int? = nil
    
    
    var size: CGFloat = 200
    
    private var computedProgress: Double {
        if let progress = progress {
            return min(max(progress, 0), 1)
        }
        if let actual = actual, let total = total, total > 0 {
            return Double(actual) / Double(total)
        }
        return 0
    }
    

    // - Si `progress` está definido y `actual`/`total` no, mostramos %.
    // - Si `actual` y `total` están definidos, mostramos fracción `actual/total`.
    private var progressText: String {
        if let progress = progress, (actual == nil || total == nil) {
            let percent = Int(min(max(progress, 0), 1) * 100)
            return "\(percent)%"
        }
        if let actual = actual, let total = total, total > 0 {
            return "\(actual)/\(total)"
        }
        return ""
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.ppBlue.opacity(0.5), lineWidth: size * 0.04)
            
            Circle()
                .trim(from: 0, to: computedProgress)
                .stroke(
                    Color.ppGreenBall,
                    style: StrokeStyle(lineWidth: size * 0.04, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut(duration: 0.8), value: computedProgress)
            
            Text(progressText)
                .font(.system(size: size * 0.15, weight: .bold, design: .rounded))
                .foregroundColor(.ppBlue)
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    PPProgressRingView()
}
