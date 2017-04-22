//
//  Parse.swift
//  Momocha
//
//  Created by sammanios on 4/6/17.
//  Copyright © 2017 keema. All rights reserved.
//

import UIKit
import MapKit

class ParseApiClient: NSObject {
    
    // TODO: IMPLEMENT THIS
    class func getUsernameFromID(id: Int) -> String {
        return "Aadarsha Shaha"
    }
    
    // TODO: IMPLEMENT THIS
    class func getRestaurantNameFromID(id: Int) -> String{
        return "Suman daju ko kuyiya momo pasal"
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
    
    // TODO: IMPLEMENT THIS
    class func getPostingUserID() -> Int {
        // search in database what is the current users ID
        return 1
    }
    
    // TODO: IMPLEMENT THIS
    class func uploadToParse(review: Review) {
        // upload the dicctionary review to parse.. the definition of Review is in the models directory
        print("This is the review of the restaurant\(String(describing: review.textreview))")
        print("This is the rating of the restaurant\(String(describing: review.rating))")
        print("This is the location of the restaurant\(String(describing: review.location))")
    }

}
