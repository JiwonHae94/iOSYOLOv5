//
//  Yolov3.swift
//  iOSYOLOv5
//
//  Created by Jiwon_Hae on 2022/01/10.
//

import Foundation
import CoreML
import Vision
import SwiftUI

class YOLOv3 : ObservableObject {
    static let shared = YOLOv3()
    
    private let modelFile = try! YOLOv3TinyInt8LUT(configuration: MLModelConfiguration())
    private let model : VNCoreMLModel
    
    private var cropAndScaleOption: VNImageCropAndScaleOption = .scaleFit
    
    @Published var objectDetected : [VNDetectedObjectObservation] = []
    @Published var objectClassified : [VNClassificationObservation] = []
    
    init(){
        self.model = try! VNCoreMLModel(for: modelFile.model)
    }
    
    func detect(imageBuffer : CVPixelBuffer){
        
        // create image handler
        let handler = VNImageRequestHandler(cvPixelBuffer: imageBuffer)
        
        // create a request to the model
        let request = VNCoreMLRequest(model: model){ request, error in
            if error != nil{
                print("failed to run model")
                return
            }
            
            if #available(iOS 12.0, *), let results = request.results as? [VNRecognizedObjectObservation] {
                self.processObjectDetectionObservations(results)
            } else if let results = request.results as? [VNClassificationObservation]  {
                self.processClassificationObservations(results)
            }
        }
        
        request.imageCropAndScaleOption = cropAndScaleOption
        request.preferBackgroundProcessing = true
        
        do {
            try handler.perform([request])
        } catch {
            print("failed to perform")
        }
        
    }
    
    @available(iOS 12.0, *)
    private func processObjectDetectionObservations(_ results: [VNRecognizedObjectObservation]) {
        objectDetected = results
        processRecognitionObservation(results as? [VNRecognizedObjectObservation])
    }
    
    private func processRecognitionObservation(_ results : [VNRecognizedObjectObservation]){
        
    }

    private func processClassificationObservations(_ results: [VNClassificationObservation]) {
        objectClassified = results
    }
}
