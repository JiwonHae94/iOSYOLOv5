//
//  Detection.swift
//  iOSYOLOv5
//
//  Created by Jiwon_Hae on 2022/01/04.
//

import Foundation
import Vision

class Detection : Identifiable {
    var id = UUID()
    var label : String
    var confidence : Float
    var boundingBox : CGRect
    
    init(label: String, confidence: Float, boundingBox: CGRect){
        self.label = label
        self.confidence = confidence
        self.boundingBox = boundingBox
    }
    
}
