//
//  MlView.swift
//  iOSYOLOv5
//
//  Created by Jiwon_Hae on 2022/01/04.
//

import SwiftUI
import Vision
import AVFoundation.AVUtilities

struct MlView: View {
    @EnvironmentObject var viewmodel : CameraViewModel
    
    var body: some View {
        ZStack{
            GeometryReader { geo in
                ForEach(0..<viewmodel.objectdDetected.count, id: \.self){ index in
                    let objDetected = viewmodel.objectdDetected[index]
                    let resizedBoundingBox = resizeBBox(objDetected.boundingBox, canvas: CGRect(x: 0, y: 0, width: geo.size.width, height: geo.size.height))

                    
                    BoundingBoxView(color: getColor(index, viewmodel.objectdDetected.count))
                        .position(x: resizedBoundingBox.minX, y: resizedBoundingBox.minY)
                        .frame(width: resizedBoundingBox.width, height: resizedBoundingBox.height)

                }

            }
            
            
        }
    }
    
    private func getColor(_ index : Int,_ total : Int) -> UIColor{
        return UIColor(hue: CGFloat(index) / CGFloat(total), saturation: 1, brightness: 1, alpha: 1)
    }
    
    
    private func resizeBBox(_ objRect: CGRect, canvas : CGRect) -> CGRect {
        
        let scale = CGAffineTransform.identity.scaledBy(x: canvas.height, y: canvas.width)
        
        let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -1)
            
                
        return objRect.applying(scale).applying(transform)
    }
}

struct MlView_Previews: PreviewProvider {
    static var previews: some View {
        MlView()
    }
}
