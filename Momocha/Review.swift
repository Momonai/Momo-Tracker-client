//
//  Review.swift
//  Momocha
//
//  Created by sammanios on 4/6/17.
//  Copyright © 2017 keema. All rights reserved.
//

import UIKit
import MapKit


class Review: NSObject {
    var postinguser: Int?
    var restaurantmentioned: Int?
    var location: CLLocationCoordinate2D?
    var textreview: String?
    var rating: Double?
    
    init(dictionary: NSDictionary) {
        postinguser = dictionary["postinguser"] as? Int
        restaurantmentioned = dictionary["restaurantmentioned"] as? Int
        location = dictionary["location"] as? CLLocationCoordinate2D
        textreview = dictionary["textreview"] as? String
        rating = dictionary["rating"] as? Double
    }
}
