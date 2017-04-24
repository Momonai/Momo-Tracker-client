//
//  Parse.swift
//  Momocha
//
//  Created by sammanios on 4/6/17.
//  Copyright © 2017 keema. All rights reserved.
//

import UIKit
import MapKit
import Parse

class ParseApiClient: NSObject {
    var posts : [PFObject]!

    
    class func getPostingUserScreenNameFromReview(foodReview: Review) -> String {
        return foodReview.postinguser!.username!
    }
    
    class func getFoodTextReview(foodReview: Review) -> String {
        return foodReview.textreview!
    }
    
    
    // TODO: IMPLEMENT THIS
    class func getRestaurantNameFromReview(foodReview: Review) -> String{
        return foodReview.restaurantName!
    }

    // TODO: IMPLEMENT THIS
    class func getCoordinatesOf(address: String) -> CLLocationCoordinate2D {
        // search for the string and return the coordinate of the address
        let mapCenter = CLLocationCoordinate2D(latitude: 37.783333, longitude: -122.416667)
        return mapCenter
    }
    
    // TODO: IMPLEMENT THIS
    class func getRestaurantMentioned(restaurantName: String) -> Int {
        // search in database in parse if a restaurant in lower string of that name exist exactly, if not then create a new id and return a new id
        return 2
    }
    
    class func getPostingUserID() -> PFUser {
        // search in database what is the current users ID
        return PFUser.current()! // Pointer column type that points to PFUser
    }
    
    class func uploadToParse(review: Review, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let post = PFObject(className: "ReviewPost")
        
        //Add relevant fields to the object
        post["review"] = review.textreview
        post["rating"] = review.rating
        post["latitude"] = review.location?.latitude
        post["longitude"] = review.location?.longitude
        post["author"] = review.postinguser
        post["restaurant_name"] = review.restaurantName
        post["restaurant_id"] = review.restaurantmentioned
        
        print (">>>>>>>>>>>>>>>>>>>>\(review.media)")

        
//        
//        let imageData = UIImagePNGRepresentation(review.media!)
//        let imageFile = PFFile(name: "image.png", data: imageData!)
//        
//        post["imageName"] = "Food Image"
//        post["imageFile"] = imageFile
        
        
        post["media"] = getPFFileFromImage(image: review.media) // PFFile column type
       
        post.saveInBackground(block: completion)
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }


}
