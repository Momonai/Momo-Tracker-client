//
//  UserDetailViewController.swift
//  Momocha
//
//  Created by sammanios on 4/6/17.
//  Copyright © 2017 keema. All rights reserved.
//

import UIKit
import Parse

class UserDetailViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBAction func onLogoutButtonPressed(_ sender: Any) {
        print("logoutPresed")
        PFUser.logOut()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserDidLogOut"), object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameLabel.text = PFUser.current()?.username
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
