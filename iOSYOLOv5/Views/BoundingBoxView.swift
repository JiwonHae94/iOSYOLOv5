//
//  BoundingBoxView.swift
//  iOSYOLOv5
//
//  Created by Jiwon_Hae on 2022/01/05.
//

import SwiftUI

struct BoundingBoxView: View {
    private let strokeWidth : CGFloat = 2
    
    let color : UIColor
    
    var body: some View {
        ZStack{
            Rectangle()
                .strokeBorder(Color.blue, lineWidth: 4)
        }
    }
    
    
    
}
