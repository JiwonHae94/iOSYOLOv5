//
//  Detection.swift
//  iOSYOLOv5
//
//  Created by Jiwon_Hae on 2022/01/04.
//

import Foundation

class Classification{
    var label : String
    var confience : String
    
    init(label: String, confidence: String){
        self.label = label
        self.confience = confidence
    }
}
