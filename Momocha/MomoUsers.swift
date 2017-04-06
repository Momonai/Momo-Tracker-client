//
//  MomoUsers.swift
//  Momocha
//
//  Created by sammanios on 4/6/17.
//  Copyright © 2017 keema. All rights reserved.
//

import UIKit

class MomoUsers: NSObject {
    var name: String?
    var screenname: String?
    var reviews: Array<Int>?
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        screenname = dictionary["screenname"] as? String
        
        reviews = dictionary["reviews"] as! Array
    }

}
