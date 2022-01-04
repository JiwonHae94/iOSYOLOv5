//
//  ContentView.swift
//  iOSYOLOv5
//
//  Created by Jiwon_Hae on 2022/01/04.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model:  CameraViewModel
    
    var body: some View {
        ZStack {
            
            FrameView(image: model.frame)
                .edgesIgnoringSafeArea(.all)
            ErrorView(error: model.error)
            
            CameraToggle()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
