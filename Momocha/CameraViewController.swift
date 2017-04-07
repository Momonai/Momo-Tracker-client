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
        descriptionTextField.clearButtonMode = UITextFieldViewMode.whileEditing
            
        let pan = UIPanGestureRecognizer(target: self, action: #selector(didPanTextField))
        descriptionTextField.addGestureRecognizer(pan)
        descriptionTextField.autocorrectionType = UITextAutocorrectionType.no
        
        self.view.addSubview(descriptionTextField)
    }
    
    
    func stopEditing() {
        descriptionTextField.endEditing(true)
        print("came to sto editing")
        clickedImageView.gestureRecognizers?.removeAll()
        // add gesture to tap to start editing
        if descriptionTextField.text == "" {
            let tap = UITapGestureRecognizer(target: self, action: #selector(writeDescription))
            clickedImageView.addGestureRecognizer(tap)
        } else {
            print("this should be empty\(descriptionTextField.text) right")
        }
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
            textViewCenter = CGPoint(x: descriptionTextField.center.x , y: descriptionTextField.center.y)
            print("Gesture ended")
        }
    }
    
    func addReviewDetails() {
        print("create a segue into adding more details")
        let finalImage = textToImage(drawText: descriptionTextField.text! as NSString, inImage: clickedImageView.image!, atPoint: textViewCenter)
        
        let alertController = UIAlertController(title: "Hey AppCoda", message: "What do you want to do?", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        let imageView = UIImageView(frame: CGRect(x: 220, y: 10, width: 40, height: 40))
        imageView.image = finalImage
        
        alertController.view.addSubview(imageView)
        
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    func textToImage(drawText text: NSString, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 12)!
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        
        let textFontAttributes = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
            ] as [String : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
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
