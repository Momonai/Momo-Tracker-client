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
        print ("Rating is now: \(starRatingView.rating)")
        
        rating = starRatingView.rating
        address = restarurantAddressTextFieldView.text
        location = getCoordinatesOf(address: address)
        restaurantName = restaurantNameTextFieldView.text
        restaurantmentioned = getRestaurantMentioned(restaurantName: restaurantName)
        currentUserID = getPostingUserID()
        
        let reviewDict : NSDictionary = [
            "postinguser": currentUserID,
            "restaurantmentioned": restaurantmentioned,
            "location": location,
            "textreview": textreview,
            "rating": rating
        ]
        
        var currentReview = Review(dictionary: reviewDict)
        uploadToParse(review: currentReview)
        
        // go to another tab
        // restaurantsTabBarController.
        
        
    }

    // TODO: IMPLEMENT THIS
    func getCoordinatesOf(address: String) -> CLLocationCoordinate2D {
        // search for the string and return an area
        let mapCenter = CLLocationCoordinate2D(latitude: 37.783333, longitude: -122.416667)
        return mapCenter
    }
    
    // TODO: IMPLEMENT THIS
    func getRestaurantMentioned(restaurantName: String) -> Int {
        // search in database if a restaurant of that name exist, if not then create a new id and return a new id
        return 2
    }
    
    // TODO: IMPLEMENT THIS
    func getPostingUserID() -> Int {
        // search in database what is the current users ID
        return 1
    }
    
    // TODO: IMPLEMENT THIS
    func uploadToParse(review: Review) {
        print("This is the review of the restaurant\(review.textreview)")
        print("This is the rating of the restaurant\(review.rating)")
        print("This is the location of the restaurant\(review.location)")
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
