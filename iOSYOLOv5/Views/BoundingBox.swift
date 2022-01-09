//
//  BoundingBox.swift
//  iOSYOLOv5
//
//  Created by Jiwon_Hae on 2022/01/10.
//

import SwiftUI
import Vision

struct BoundingBox: View {
    var observation : VNDetectedObjectObservation
    var color : UIColor
    var imageRect : CGRect
    
    private let strokeWidth: CGFloat = 2
    
    var body: some View {
        let convertedRect = VNImageRectForNormalizedRect(observation.boundingBox, Int(imageRect.width), Int(imageRect.height))
        
        let x = convertedRect.minX + imageRect.minX
        let y = (imageRect.height - convertedRect.maxY) + imageRect.minY
        let rect = CGRect(origin: CGPoint(x: x, y: y), size: convertedRect.size)
        
        log(msg: "\(x), \(y) \(rect.width) \(rect.height) \(observation.labels.first?.identifier)")
        
        Path(rect)
            .stroke(lineWidth: strokeWidth)
            .foregroundColor(.blue)
    }
    
    private func log(msg : String) -> some View{
        print(msg)
        return EmptyView()
    }
}
