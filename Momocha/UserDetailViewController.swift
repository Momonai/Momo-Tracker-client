//
//  UserDetailViewController.swift
//  Momocha
//
//  Created by sammanios on 4/6/17.
//  Copyright © 2017 keema. All rights reserved.
//

import UIKit
import Parse

class UserDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var posts : [PFObject]!
    var myReviews : [Review]!

    @IBOutlet weak var userNameLabel: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func onLogoutButtonPressed(_ sender: Any) {
        print("logoutPresed")
        PFUser.logOut()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserDidLogOut"), object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        userNameLabel.text = PFUser.current()?.username
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // defer computing the height of each row until the user scrolls the table
        tableView.estimatedRowHeight = 120

        var returnFromParse = [Review]()
        
        let query = PFQuery(className: "ReviewPost")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        query.whereKey("author", equalTo: PFUser.current())
        
        //query.includeKey("author": PFUser.current())
        
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
                
                
                self.myReviews = returnFromParse
                //print("Post is : \(self.reviews[0].restaurantName!)")
                self.tableView.reloadData()
                // do something with the data fetched
            } else {
                print("Error! : ", error?.localizedDescription)
                // handle error
            }
            self.tableView.reloadData()
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let reviews = self.myReviews {
            return reviews.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // put the returned [NSDictionary] to the model post
        
        let restaurantcell = Bundle.main.loadNibNamed("RestaurantTableViewCell", owner: self, options: nil)?.first as! RestaurantTableViewCell
        
        
        print(">>>>>>>", self.myReviews[indexPath.row].postinguser!.username!)
        print(">>>>>>>", self.myReviews[indexPath.row].media)
        restaurantcell.review = self.myReviews[indexPath.row]
        
        let post = posts[indexPath.row]
        print("this post\(post)")
        
        
        let photoPFFile = post["media"] as? PFFile
        
        restaurantcell.postImageView.file = photoPFFile
        
        restaurantcell.postImageView.loadInBackground()
        
        
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
