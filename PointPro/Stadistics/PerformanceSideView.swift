//
//  PerformanceSideView.swift
//  PointPro
//
//  Created by Carlos Suarez on 23/6/25.
//

import SwiftUI

struct PerformanceSideView: View {
    var wonOpeningCount: Int
    var wonOpeningTotal: Int
    
    var lostOpeningCount: Int
    var lostOpeningTotal: Int
    
    var body: some View {
        HStack(spacing: 20) {
            PPSectionCard(title: "text.performSide".localizedValue) {
                ProgressRingView(actual: wonOpeningCount,total: wonOpeningTotal,size: 120)
            }
            
            PPSectionCard(title: "text.performSide".localizedValue) {
                ProgressRingView(actual: lostOpeningCount,total: lostOpeningTotal,size: 120)
            }
        }
    }
}


#Preview {
    PerformanceSideView(wonOpeningCount: 20,
                        wonOpeningTotal: 30,
                        lostOpeningCount: 10,
                        lostOpeningTotal: 30)
}
