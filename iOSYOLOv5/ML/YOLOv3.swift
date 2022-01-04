//
//  YOLOv5.swift
//  iOSYOLOv5
//
//  Created by Jiwon_Hae on 2022/01/04.
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
    
    @Published var objectDetected : [Detection] = []
    @Published var objectClassified : Classification? = nil
    
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
            
            if let results = request.results as? [VNClassificationObservation]{
                self.processClassificationObservations(results)
            }else if #available(iOS 12.0, *), let results = request.results as? [VNRecognizedObjectObservation] {
                self.processObjectDetectionObservations(results)
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
        var recognizedObjects = [Detection]()
        for i in 0..<results.count{
            let observation = results[i]
            
            guard let firstLabel = observation.labels.first?.identifier else {
                continue
            }
            
            recognizedObjects.append(Detection(label: firstLabel, confidence: observation.confidence, boundingBox: observation.boundingBox))
        }
        
        objectDetected = recognizedObjects
    }

    private func processClassificationObservations(_ results: [VNClassificationObservation]) {
        if let _objectClassified = results.first {
            objectClassified = Classification(label: _objectClassified.identifier, confidence: String(format: "%.2f", _objectClassified.confidence * 100))
            print("ml classified objects : \(_objectClassified.identifier)")
        }
    }
}
