//
//  Restaurant.swift
//  Momocha
//
//  Created by sammanios on 4/6/17.
//  Copyright © 2017 keema. All rights reserved.
//

import UIKit
import MapKit

class Restaurant: NSObject {
    var name: String?
    var screenname: String?
    var likeCount: Int?
    var dislikeCount: Int?
    var reviewers: Array<Int>?
    var reviews: Array<Int>?
    var coordinate: CLLocationCoordinate2D?
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        screenname = dictionary["screenname"] as? String
        likeCount = dictionary["likecount"] as? Int
        dislikeCount = dictionary["dislikeCount"] as? Int
        reviewers = dictionary["reviewers"] as? Array
        reviews = dictionary["reviews"] as? Array
        coordinate = dictionary["coordinate"] as? CLLocationCoordinate2D
    }
}
