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
    
    var descriptionTextView: UITextView!
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

        
        descriptionTextView = UITextView(frame: CGRect(x: 0, y: (self.view.frame.height) / 2, width: self.view.frame.width, height: 40))
        descriptionTextView.textColor = UIColor.white
        descriptionTextView.textAlignment = .center
        textViewCenter = CGPoint(x: descriptionTextView.center.x , y: descriptionTextView.center.y)
        
        descriptionTextView.backgroundColor = UIColor.gray
        descriptionTextView.becomeFirstResponder()
        // descriptionTextView.cha
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(didPanTextField))
        descriptionTextView.addGestureRecognizer(pan)
        descriptionTextView.autocorrectionType = UITextAutocorrectionType.no
        
        self.view.addSubview(descriptionTextView)
    }
    
    
    func stopEditing() {
        descriptionTextView.endEditing(true)
        print("came to stop editing")
        clickedImageView.gestureRecognizers?.removeAll()
        // add gesture to tap to start editing
        if descriptionTextView.text == "" {
            for v in self.view.subviews {
                if v is UITextField {
                    v.removeFromSuperview()
                }
            }

            let tap = UITapGestureRecognizer(target: self, action: #selector(writeDescription))
            clickedImageView.addGestureRecognizer(tap)
        } else {
            print("this should not be empty\(descriptionTextView.text) right")
        }
    }
    
    
    func didPanTextField(_ sender: UIPanGestureRecognizer) {
        //  access the translation parameter of the UIPanGestureRecocognizer and store it in a constant.
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            textViewCenter = CGPoint(x: descriptionTextView.center.x , y: descriptionTextView.center.y)
            print("Gesture began")
        } else if sender.state == .changed {
            descriptionTextView.center = CGPoint(x: textViewCenter.x, y: textViewCenter.y + translation.y)
            
            print("Gesture is changing")
        } else if sender.state == .ended {
            textViewCenter = CGPoint(x: descriptionTextView.center.x , y: descriptionTextView.center.y)
            print("Gesture ended")
        }
    }
    
    func addReviewDetails() {
        print("create a segue into adding more details")
        let finalImage: UIImage
        if descriptionTextView == nil {
            finalImage = clickedImageView.image!
        } else {
            // finalImage = textToImage(drawText: descriptionTextView.text! as NSString, inImage: clickedImageView.image!, atPoint: textViewCenter)
            finalImage = textToImage1(text: descriptionTextView.text!, image: clickedImageView.image!, point: textViewCenter)
        }
        
        let alertController = UIAlertController(title: "Hey AppCoda", message: "What do you want to do?", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        let imageView = UIImageView(frame: CGRect(x: alertController.view.center.x, y: 10, width: 140, height: 140))
        imageView.image = finalImage
        
        alertController.view.addSubview(imageView)
        
        
        present(alertController, animated: true, completion: nil)
    }
    
    func textToImage1(text: String, image: UIImage, point: CGPoint) -> UIImage {
        
        let imageView = UIImageView(image: image)
        imageView.backgroundColor = UIColor.clear
        imageView.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        
        // hardcoded value
//        let label = UILabel(frame: CGRect(x: point.x, y: point.y, width: image.size.width, height: 40))
        print ("Point.y:  \(point.y)")
        let label = UILabel(frame: CGRect(x: 0, y: point.y, width: image.size.width, height: 40))



        label.backgroundColor = UIColor.gray
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = text
        label.numberOfLines = 0
        // label.sizeToFit()
        
        
        
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, 0);
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let imageWithText = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return imageWithText!
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
