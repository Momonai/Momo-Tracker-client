//
//  CameraScreenViewController.swift
//  Momocha
//
//  Created by sammanios on 4/6/17.
//  Copyright © 2017 keema. All rights reserved.
//

import UIKit
import SwiftyCam
import AVFoundation

class CameraScreenViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate  {
    
    // AVCaptureVideoDataOutputSampleBufferDelegate
    @IBOutlet weak var cameraView: UIView!
    
    var photoButton:UIImageView!
    
    var crossButton:UIImageView!
    
    var imageView:UIImageView!
    
    var first_time = true
    
    let captureSession = AVCaptureSession()
    
    var captureDevice: AVCaptureDevice?
    
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var frontCamera: Bool = false
    
    var shouldTakePhoto:Bool = false
    
    var stillImageOutput: AVCaptureStillImageOutput = AVCaptureStillImageOutput()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareCamera()
        addButtons()
        
        // Do any additional setup after loading the view.
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        
    }
 
    
    @IBAction func onCapture(_ sender: Any) {
        print("capturing")
    }

    
    func prepareCamera() {
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        
        if let availableDevices = AVCaptureDeviceDiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: .back).devices {
            captureDevice = availableDevices.first
            
            print("capture device used: \(captureDevice)")
            
            beginSession()
            addButtons()

            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
            imageView.contentMode = .scaleAspectFill
            
            view.addSubview(imageView)
        }
    }

//Adds buttons to camera screen
func addButtons() {
    
    let photoButtonWidth:CGFloat = 65.0
    photoButton = UIImageView(frame: CGRect(x: view.frame.midX - photoButtonWidth / 2, y: view.frame.height - photoButtonWidth - 20, width: photoButtonWidth, height: photoButtonWidth))
    photoButton.image = UIImage(named: "take-photo")
    let photoRecognizer = UITapGestureRecognizer(target: self, action: #selector(takePhoto))
    photoButton.addGestureRecognizer(photoRecognizer)
    photoButton.isUserInteractionEnabled = true
    view.addSubview(photoButton)
}


    func beginSession() {

        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            
            captureSession.addInput(captureDeviceInput)
        }catch {
            print(error.localizedDescription)
        }
        
        if let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession) {
            
            let bounds = view.layer.bounds
            previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            previewLayer.bounds = bounds
            previewLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
            
            self.previewLayer = previewLayer
            self.view.layer.addSublayer(self.previewLayer!)
            self.previewLayer?.frame = self.view.layer.frame
            captureSession.startRunning()
            
            let dataOutput = AVCaptureVideoDataOutput()
            dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String):NSNumber(value: kCVPixelFormatType_32BGRA)]
            dataOutput.alwaysDiscardsLateVideoFrames = true
            
            if captureSession.canAddOutput(dataOutput) {
                captureSession.addOutput(dataOutput)
            }
            
            captureSession.commitConfiguration()
            
            let queue = DispatchQueue(label: "captureQueue")
            dataOutput.setSampleBufferDelegate(self, queue: queue)
            
            
        }
    }
    

    func takePhoto() {
        shouldTakePhoto = true
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        
        
        if shouldTakePhoto {
            shouldTakePhoto = false
            
            if let image = getImageFromSampleBuffer(buffer: sampleBuffer) {
                
                
//                let photoButtonWidth:CGFloat = 65.0
//                photoButton = UIImageView(frame: CGRect(x: view.frame.midX - photoButtonWidth / 2, y: view.frame.height - photoButtonWidth - 20, width: photoButtonWidth, height: photoButtonWidth))
//                photoButton.image = UIImage(named: "take-photo")
//                let photoRecognizer = UITapGestureRecognizer(target: self, action: #selector(takePhoto))
//                photoButton.addGestureRecognizer(photoRecognizer)
//                photoButton.isUserInteractionEnabled = true
//                view.addSubview(photoButton)
                
                
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.photoButton.isUserInteractionEnabled = false
                    let crss = UIImage(named: "cross")
                    
                    let crossButtonWidth:CGFloat = 65.0
                    self.crossButton = UIImageView(frame: CGRect(x: self.view.frame.midX - crossButtonWidth / 2, y: self.view.frame.height - crossButtonWidth - 20, width: crossButtonWidth, height: crossButtonWidth))
                    self.crossButton.image = UIImage(named: "cross")
                    let crossRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.clearImage))
                    self.crossButton.addGestureRecognizer(crossRecognizer)
                    self.crossButton.isUserInteractionEnabled = true
                    self.view.addSubview(self.crossButton)

                    
                    
                    
//                    let crossButtonWidth:
//                    self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: crss, style: .plain, target: self, action: #selector(self.clearImage))
                }
                
            }
            
        }
    }
    
    func getImageFromSampleBuffer(buffer: CMSampleBuffer) -> UIImage? {
        
        if let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) {
            let cIImage = CIImage(cvPixelBuffer: pixelBuffer)
            let context = CIContext()
            
            let imageRect = CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))
            
            if let image = context.createCGImage(cIImage, from: imageRect) {
                return UIImage(cgImage: image, scale: UIScreen.main.scale, orientation: .right)
            }
        }
        
        return nil
    }
    
    func clearImage() {
        imageView.image = nil
        photoButton.isUserInteractionEnabled = true
        // self.navigationItem.leftBarButtonItem = nil
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
