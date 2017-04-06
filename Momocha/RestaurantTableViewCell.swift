//
//  RestaurantTableViewCell.swift
//  Momocha
//
//  Created by sammanios on 4/6/17.
//  Copyright © 2017 keema. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    var review: Review! {
        didSet {
            // get posting user name
            let postingUserScreenName = Parse.getUsernameFromID(id: review.postinguser!)
            
            // get restaurant name
            let restaurantName = Parse.getRestaurantNameFromID(id: review.restaurantmentioned!)
            
            descriptionLabel.text = review.textreview
            userNameLabel.text = postingUserScreenName
            restaurantNameLabel.text = restaurantName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
