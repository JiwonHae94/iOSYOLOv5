//
//  ContentView.swift
//  iOSYOLOv5
//
//  Created by Jiwon_Hae on 2022/01/04.
//

import SwiftUI

class ContentViewModel : ObservableObject{
    @Published var frame : CGImage?
    @Published var error : CameraError?
    
    var comicFilter = false
    var monoFilter = false
    var crystalFilter = false
    var currentLensFacing = false
    
    private let cameraManager = CameraManager.shared
    private let frameManager = FrameManager.shared
    
    
    init() {
        setupSubscriptions()
    }
    
    func setupSubscriptions() {
        cameraManager.$error
            .receive(on: RunLoop.main)
            .map { $0 }
            .assign(to: &$error)
        
        frameManager.$current
            // receive frame on main thread
            .receive(on: RunLoop.main)
            .compactMap { buffer in
                // convert buffer to CGImage for display
                return CGImage.create(from: buffer)
            }
            .assign(to: &$frame)
    }
    
    func switchCamera(){
        currentLensFacing.toggle()
        cameraManager.switchCamera()
    }
}

