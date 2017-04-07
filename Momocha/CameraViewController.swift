//
//  CameraViewController.swift
//  Momocha
//
//  Created by sammanios on 4/6/17.
//  Copyright © 2017 keema. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var pickedImage: UIImage!
    
    var hasImage: Bool! = false
    
    var clickedImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
            
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if hasImage {
            print ("Photo clicked and now being displayed")
            // display image
            clickedImageView = UIImageView(image: pickedImage)
            clickedImageView.frame = self.view.frame
            clickedImageView.backgroundColor = .black
            clickedImageView.contentMode = .scaleAspectFit
            clickedImageView.isUserInteractionEnabled = false
            self.view.addSubview(clickedImageView)
            
            // add a cross button
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "cross"), style: .plain, target: self, action: #selector(dismissFullscreenImage))

            
//            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
//            newImageView.addGestureRecognizer(tap)
//            self.view.addSubview(newImageView)
            
        } else {
            print("camera screen accessed \n")
            prepareCamera()
        }
    }
    
    func prepareCamera() {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            vc.sourceType = .camera
        } else {
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion:nil)
    }

    func dismissFullscreenImage() {
        clickedImageView.removeFromSuperview()
        // recreate the camera
        prepareCamera()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        print("selected the image")
        
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        pickedImage = editedImage
        
        
        // Do something with the images (based on your use case)
        hasImage = true
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
        // performSegue(withIdentifier: "addDetailSegue", sender: self)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("preparing for segue")
    }

}
