//
//  RestaurantListViewController.swift
//  Momocha
//
//  Created by sammanios on 4/6/17.
//  Copyright © 2017 keema. All rights reserved.
//

import UIKit
import MapKit
import Parse
import ParseUI

struct cellData {
    let cell: Int!
    let text: String!
    let image: UIImage!
}

class RestaurantListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var posts : [PFObject]!
    
    @IBOutlet weak var tableView: UITableView!
    
    var reviews: [Review]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        // automatic height measurement based on content of each cell
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // defer computing the height of each row until the user scrolls the table
        tableView.estimatedRowHeight = 120
        
        
        
        var returnFromParse = [Review]()
        
        // Fetch all posts from Parse
        // construct PFQuery
        let query = PFQuery(className: "ReviewPost")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                self.posts = posts
                print("<<<<<<<<>>>>>>>>>Post is : ", posts)
                for post in posts {
                    let receivedPost : NSDictionary = [
                        "postinguser" : post["author"],
                        "restaurantmentioned" : post["restaurant_id"],
                        "location" : CLLocationCoordinate2D(latitude: post["latitude"] as! CLLocationDegrees, longitude: post["longitude"] as! CLLocationDegrees),
                        "textreview" : post["review"],
                        "rating" : post["rating"],
                        "restaurantName" : post["restaurant_name"]
                    ]
                    
                    let receivedReview = Review(dictionary: receivedPost)
                    returnFromParse.append(receivedReview)
                }
                
                
                self.reviews = returnFromParse
                //print("Post is : \(self.reviews[0].restaurantName!)")
                self.tableView.reloadData()
                // do something with the data fetched
            } else {
                print("Error! : ", error?.localizedDescription)
                // handle error
            }
            self.tableView.reloadData()
        }

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let reviews = self.reviews {
            return reviews.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // put the returned [NSDictionary] to the model post
        
        let restaurantcell = Bundle.main.loadNibNamed("RestaurantTableViewCell", owner: self, options: nil)?.first as! RestaurantTableViewCell
        
        print(">>>>>>>", self.reviews[indexPath.row].postinguser!.username!)
        print(">>>>>>>", self.reviews[indexPath.row].media)
        restaurantcell.review = self.reviews[indexPath.row]
        
        let post = posts[indexPath.row]
        print("this post\(post)")

        
        let photoPFFile = post["media"] as? PFFile

        restaurantcell.postImageView.file = photoPFFile

        restaurantcell.postImageView.loadInBackground()

        
        return restaurantcell
    }

//    override func viewDidAppear(_ animated: Bool) {
//        var returnFromParse = [Review]()
//        
//        // Fetch all posts from Parse
//        // construct PFQuery
//        let query = PFQuery(className: "ReviewPost")
//        query.order(byDescending: "createdAt")
//        query.includeKey("author")
//        query.limit = 20
//        
//        // fetch data asynchronously
//        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
//            if let posts = posts {
//                self.posts = posts
//                print("<<<<<<<<>>>>>>>>>Post is : ", posts)
//                for post in posts {
//                    let receivedPost : NSDictionary = [
//                        "postinguser" : post["author"],
//                        "restaurantmentioned" : post["restaurant_id"],
//                        "location" : CLLocationCoordinate2D(latitude: post["latitude"] as! CLLocationDegrees, longitude: post["longitude"] as! CLLocationDegrees),
//                        "textreview" : post["review"],
//                        "rating" : post["rating"],
//                        "restaurantName" : post["restaurant_name"]
//                    ]
//                    
//                    let receivedReview = Review(dictionary: receivedPost)
//                    returnFromParse.append(receivedReview)
//                }
//                
//                
//                self.reviews = returnFromParse
//                //print("Post is : \(self.reviews[0].restaurantName!)")
//                self.tableView.reloadData()
//                // do something with the data fetched
//            } else {
//                print("Error! : ", error?.localizedDescription)
//                // handle error
//            }
//            self.tableView.reloadData()
//        }
//
//    }
}
