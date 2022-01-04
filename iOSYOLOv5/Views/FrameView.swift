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
                
                Image(image, scale: 1.0, orientation:
                        viewModel.currentLensFacing ? .upMirrored : .upMirrored, label: label)
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height,
                        alignment: .center)
                    .clipped()
                }
            } else {
                EmptyView()
            }
    }
}
