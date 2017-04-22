//
//  AddImageDetailViewController.swift
//  Momocha
//
//  Created by sammanios on 4/6/17.
//  Copyright © 2017 keema. All rights reserved.
//

import UIKit
import MapKit
import Cosmos

class AddImageDetailViewController: UIViewController {

    var textreview: String!
    var rating: Double!
    var restaurantmentioned: Int!
    var postinguser: Int!
    var address: String!
    var location: CLLocationCoordinate2D!
    var editedImage: UIImage!
    var restaurantName: String!
    var currentUserID: Int!
    
    @IBOutlet weak var starRatingView: CosmosView!
    
    @IBOutlet weak var restarurantAddressTextFieldView: UITextField!
    
    @IBOutlet weak var restaurantNameTextFieldView: UITextField!
    @IBOutlet weak var reviewImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print ("came to add detail with: \(String(describing: textreview))")
        reviewImageView.image = editedImage
        starRatingView.rating = 0
    }
    
    @IBAction func onUpload(_ sender: Any) {
        print("works")
        print ("We need everything")
        
        rating = starRatingView.rating
        address = restarurantAddressTextFieldView.text
        location = ParseApiClient.getCoordinatesOf(address: address)
        restaurantName = restaurantNameTextFieldView.text
        restaurantmentioned = ParseApiClient.getRestaurantMentioned(restaurantName: restaurantName)
        currentUserID = ParseApiClient.getPostingUserID()
        
        let reviewDict : NSDictionary = [
            "postinguser": currentUserID,
            "restaurantmentioned": restaurantmentioned,
            "location": location,
            "textreview": textreview,
            "rating": rating
        ]
        
        let currentReview = Review(dictionary: reviewDict)
        ParseApiClient.uploadToParse(review: currentReview)
        
        // go to another tab
        // restaurantsTabBarController.
        let tabBarController : UITabBarController = (self.view.window?.rootViewController as? UITabBarController)!
        
        dismiss(animated: false, completion: nil)
        tabBarController.selectedIndex = 1
        
    }

        
    @IBAction func onBack(_ sender: Any) {
        print("workds too")
        dismiss(animated: true, completion: nil)
        
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
