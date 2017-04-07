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
    
    var userCanceledClickingImage: Bool! = false
    
    var descriptionTextField: UITextField!
    var textViewCenter: CGPoint!
    
    
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
            clickedImageView.isUserInteractionEnabled = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(writeDescription))
            clickedImageView.addGestureRecognizer(tap)
            
            self.view.addSubview(clickedImageView)
            
            // add a cross button
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "cross"), style: .plain, target: self, action: #selector(dismissFullscreenImage))
            
            // add a ok button
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image:UIImage(named: "take-photo"), style: .plain, target: self, action: #selector(addReviewDetails))
            
        } else {
            print("camera screen accessed \n")
            if userCanceledClickingImage {
                userCanceledClickingImage = false
                // segue to other tab
                // performSegue(withIdentifier: "addDetailSegue", sender: self)
                // UIWindow.rootVi?.selectedIndex = 1
                // make it change to the next tab, cant do for now
                // dismiss(animated: true, completion: nil)
                print("change to the details tab on cancle")
                prepareCamera()
                
            } else {
                prepareCamera()
            }
        }
    }
    
    func writeDescription(_ sender: UIPanGestureRecognizer) {
        print("tapped")
        
        // remove all gesture recognizers
        clickedImageView.gestureRecognizers?.removeAll()
        
        // add tap to stop editing
        let tap = UITapGestureRecognizer(target: self, action: #selector(stopEditing))
        clickedImageView.addGestureRecognizer(tap)

        
        descriptionTextField = UITextField(frame: CGRect(x: 0, y: (self.view.frame.height) / 2, width: self.view.frame.width, height: 40))
        textViewCenter = CGPoint(x: descriptionTextField.center.x , y: descriptionTextField.center.y)
        
        descriptionTextField.backgroundColor = UIColor.gray
        descriptionTextField.becomeFirstResponder()
            
        let pan = UIPanGestureRecognizer(target: self, action: #selector(didPanTextField))
        descriptionTextField.addGestureRecognizer(pan)
        
        self.view.addSubview(descriptionTextField)
        
        
        
//        let stepsTextField = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
//        stepsTextField.placeholder = "Enter text here"
//        stepsTextField.font = UIFont.systemFont(ofSize: 15)
//        stepsTextField.borderStyle = UITextBorderStyle.roundedRect
//        stepsTextField.autocorrectionType = UITextAutocorrectionType.no
//        stepsTextField.keyboardType = UIKeyboardType.default
//        stepsTextField.returnKeyType = UIReturnKeyType.done
//        stepsTextField.clearButtonMode = UITextFieldViewMode.whileEditing;
//        stepsTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.centerf
    }
    
    
    func stopEditing() {
        descriptionTextField.endEditing(true)
        print("came to sto editing")
        clickedImageView.gestureRecognizers?.removeAll()
        // add gesture to tap to start editing
        let tap = UITapGestureRecognizer(target: self, action: #selector(writeDescription))
        clickedImageView.addGestureRecognizer(tap)
    }
    
    
    func didPanTextField(_ sender: UIPanGestureRecognizer) {
        //  access the translation parameter of the UIPanGestureRecocognizer and store it in a constant.
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            textViewCenter = CGPoint(x: descriptionTextField.center.x , y: descriptionTextField.center.y)
            print("Gesture began")
        } else if sender.state == .changed {
            descriptionTextField.center = CGPoint(x: 0, y: textViewCenter.y + translation.y)
            
            print("Gesture is changing")
        } else if sender.state == .ended {
            print("Gesture ended")
        }
    }
    
    func addReviewDetails() {
        print("create a segue into adding more details")
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
        hasImage = false
        pickedImage = nil
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
//         performSegue(withIdentifier: "addDetailSegue", sender: self)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("user cancled")
        userCanceledClickingImage = true
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("preparing for segue")
    }

}
