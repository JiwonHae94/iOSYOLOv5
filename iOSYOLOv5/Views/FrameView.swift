//
//  FrameView.swift
//  iOSYOLOv5
//
//  Created by Jiwon_Hae on 2022/01/04.
//


import SwiftUI

struct FrameView: View {
    @EnvironmentObject var viewModel : CameraViewModel
    var image: CGImage?

    private let label = Text("Video feed")

    var body: some View {
        if let image = image {
            GeometryReader { geometry in
                ZStack{
                    Image(image, scale: 1.0, orientation: .upMirrored ,label: label)
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: geometry.size.width,
                            height: geometry.size.height,
                            alignment: .center)
                        .clipped()
                    }
                
                    ForEach(0..<viewModel.objectdDetected.count, id: \.self){ index in
                        let objDetected = viewModel.objectdDetected[index]
                        BoundingBox(observation: objDetected, color: .blue, imageRect: CGRect(x: 0, y: 0, width: geometry.size.width, height: geometry.size.height))
                        
                        .frame(
                            width: geometry.size.width,
                            height: geometry.size.height,
                            alignment: .center)
                    }
                
                }
            } else {
                EmptyView()
            }
    }
    
    
    private func resizeBBox(_ objRect: CGRect, width : CGFloat, height: CGFloat) -> CGRect {
        let scale = CGAffineTransform.identity.scaledBy(x: width, y: height)
        let transform = CGAffineTransform(scaleX: 640 / height, y: -1).translatedBy(x: 0, y: -1)
        return objRect.applying(transform).applying(scale)
    }
    
    
    private func getColor(_ index : Int,_ total : Int) -> UIColor{
        return UIColor(hue: CGFloat(index) / CGFloat(total), saturation: 1, brightness: 1, alpha: 1)
    }
}
