//
//  CameraViewController.swift
//  Momocha
//
//  Created by sammanios on 4/6/17.
//  Copyright © 2017 keema. All rights reserved.
//

import UIKit
import SwiftyCam

class CameraViewController: SwiftyCamViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // cameraDelegate = self as! SwiftyCamViewControllerDelegate
        
        // add capture button
//        let kaptureButton = UIButton()
//        kaptureButton.frame = (frame: CGRect(x: self.view.frame.size.width - 60, y: 20, width: 50, height: 50)) as! CGRect
//        kaptureButton.backgroundColor = UIColor.red
//        kaptureButton.setTitle("Name your Button ", for: .normal)
        
        
//        let captureButton = SwiftyCamButton(frame: kaptureButton.frame)
        //captureButton.delegate = self
    }

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
