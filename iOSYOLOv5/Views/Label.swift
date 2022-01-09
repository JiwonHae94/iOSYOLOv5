//
//  Labels.swift
//  iOSYOLOv5
//
//  Created by Jiwon_Hae on 2022/01/10.
//

import SwiftUI
import Vision

struct Label: View {
    var observation : VNRecognizedObjectObservation
    var rect : CGRect
    
    
    private let strokeWidth: CGFloat = 2
    
    var body: some View {
        if let firstLabel = observation.labels.first?.identifier {
            Text(firstLabel)
                .foregroundColor(.black)
                .font(.system(size : 13))
                .scaledToFit()
                .position(x: rect.minX - strokeWidth / 2,
                          y: rect.minY)
        } else{
            EmptyView()

        }
        
    }
}
