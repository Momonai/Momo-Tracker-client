//
//  CameraScreenViewController.swift
//  Momocha
//
//  Created by sammanios on 4/6/17.
//  Copyright © 2017 keema. All rights reserved.
//

import UIKit
import SwiftyCam

class CameraScreenViewController: SwiftyCamViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, SwiftyCamViewControllerDelegate {
    var first_time = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let captureButton = SwiftyCamButton(frame:CGRect(x:25, y:10, width: 100, height:150))
        captureButton.delegate = self
        
        //first_time = true
        

        // Do any additional setup after loading the view.
        // use this: SwiftyCamViewController

    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
        // Called when takePhoto() is called or if a SwiftyCamButton initiates a tap gesture
        // Returns a UIImage captured from the current session
        print("clicked")
    }
    
    
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didSwitchCameras camera: SwiftyCamViewController.CameraSelection) {
        // Called when user switches between cameras
        // Returns current camera selection
        print("switched camera")
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        print ("####### came here")
//        if (!first_time) {
//            let vc = UIImagePickerController()
//            vc.delegate = self
//            vc.allowsEditing = true
//            
//            if UIImagePickerController.isSourceTypeAvailable(.camera) {
//                vc.sourceType = .camera
//            } else {
//                vc.sourceType = .photoLibrary
//            }
//            
//            self.present(vc, animated: true, completion: nil)
//        } else {
//            first_time = false
//        }
//        first_time = false
//    }
    
    // delegate to handle the image
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        print("came here with the image")
//        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//        
//        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
//        
//        print("image taken and saved")
//        // dismiss(animated: true, completion: nil)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
