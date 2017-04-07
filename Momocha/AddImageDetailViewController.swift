//
//  AddImageDetailViewController.swift
//  Momocha
//
//  Created by sammanios on 4/6/17.
//  Copyright © 2017 keema. All rights reserved.
//

import UIKit
import MapKit

class AddImageDetailViewController: UIViewController {

    var textreview: String!
    var rating: Int!
    var restaurantmentioned: Int!
    var postinguser: Int!
    var location: CLLocationCoordinate2D!
    var editedImage: UIImage!
    
    
    @IBOutlet weak var restarurantAddressTextFieldView: UITextField!
    
    @IBOutlet weak var restaurantNameTextFieldView: UITextField!
    @IBOutlet weak var reviewImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print ("came to add detail with: \(String(describing: textreview))")
        reviewImageView.image = editedImage
    }
    
    @IBAction func onUpload(_ sender: Any) {
        print("works")
    }

    @IBAction func onBack(_ sender: Any) {
        print("workds too")
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
