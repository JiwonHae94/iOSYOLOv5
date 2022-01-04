//
//  MlView.swift
//  iOSYOLOv5
//
//  Created by Jiwon_Hae on 2022/01/04.
//

import SwiftUI

struct MlView: View {
    @EnvironmentObject var viewmodel : CameraViewModel
    
    var body: some View {
        VStack{
            Text(viewmodel.$objectClassified)
        }
    }
}

struct MlView_Previews: PreviewProvider {
    static var previews: some View {
        MlView()
    }
}
