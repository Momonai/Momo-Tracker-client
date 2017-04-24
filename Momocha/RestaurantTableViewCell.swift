//
//  RestaurantTableViewCell.swift
//  Momocha
//
//  Created by sammanios on 4/6/17.
//  Copyright © 2017 keema. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class RestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    var review: Review! {
        didSet {
            // get posting user name
            let postingUserScreenName = ParseApiClient.getPostingUserScreenNameFromReview(foodReview: review)
            
            // get restaurant name
            let restaurantName = ParseApiClient.getRestaurantNameFromReview(foodReview: review)
            
            // get foods review
            let foodTextReview = ParseApiClient.getFoodTextReview(foodReview: review)
            
            descriptionLabel.text = foodTextReview
            userNameLabel.text = postingUserScreenName
            restaurantNameLabel.text = restaurantName
            //postImageView.image = review.media
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("hoho")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
