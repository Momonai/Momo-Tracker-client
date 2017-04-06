//
//  RestaurantListViewController.swift
//  Momocha
//
//  Created by sammanios on 4/6/17.
//  Copyright © 2017 keema. All rights reserved.
//

import UIKit
import MapKit

struct cellData {
    let cell: Int!
    let text: String!
    let image: UIImage!
}

class RestaurantListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var restaurants: [NSDictionary]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        // automatic height measurement based on content of each cell
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // defer computing the height of each row until the user scrolls the table
        tableView.estimatedRowHeight = 120
        
        
        // make a call to parse to get the data
        let restrnts : NSDictionary = [
            "name" : "Mamako momo pasal",
            "screenname" : "Mamako momo pasal",
            "likecount" : 42,
            "dislikeCount" : 12,
            "reviewers": [1, 2],
            "reviews": [2, 4],
            "coordinate": CLLocationCoordinate2D(latitude: 37.783333, longitude: -122.416667)
        ]
        
        // make a call to parse to get all recent posts
        let a: NSDictionary = [
            "postinguser" : 2,
            "restaurantmentioned" : 3,
            "location" : CLLocationCoordinate2D(latitude: 37.783333, longitude: -122.416667),
            "textreview" : "Manai chuney mitho",
            "rating" : 2,
        ]
        
        
        let returnFromParse = [a,a, a, a]
        
        restaurants = returnFromParse
        tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let restaurants = self.restaurants {
            return restaurants.count
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // put the returned [NSDictionary] to the model post
        
        let restaurantcell = Bundle.main.loadNibNamed("RestaurantTableViewCell", owner: self, options: nil)?.first as! RestaurantTableViewCell
        
        // use the modal
        // let currentPost = Review(dictionary: restaurants[indexPath])
        
        let currentPost = Review(dictionary: restaurants[0])
        
        print(">>>>>>>>>>>> indexpath.row: \(currentPost.textreview!)")
        
        //restaurantcell.descriptionLabel.text = currentPost.textreview
        restaurantcell.review = currentPost

        
        return restaurantcell
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
