//
//  RestaurantListViewController.swift
//  Momocha
//
//  Created by sammanios on 4/6/17.
//  Copyright © 2017 keema. All rights reserved.
//

import UIKit

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
        //let restaurant = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! RestaurantTableViewCell
        let a : NSDictionary = [
            "anObject" : "someObject",
            "helloString" : "this is 1",
            "magicNumber" : 42,
            "aValue" : "someValue"
        ]
        
        let b : NSDictionary = [
            "anObject" : "someObject",
            "helloString" : "this is 2",
            "magicNumber" : 42,
            "aValue" : "someValue"
        ]
        
        let c = [a, b]
        
        let restaurantcell = Bundle.main.loadNibNamed("RestaurantTableViewCell", owner: self, options: nil)?.first as! RestaurantTableViewCell
        
        print(">>>>>>>>>>>> indexpath.row: \(c[indexPath.row])")
        let description = c[indexPath.row]["helloString"]!
        
        restaurantcell.descriptionLabel.text = description as! String
        
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
