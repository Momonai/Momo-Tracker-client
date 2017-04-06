//
//  MainNavigationViewController.swift
//  Momocha
//
//  Created by sammanios on 4/6/17.
//  Copyright © 2017 keema. All rights reserved.
//

import UIKit

class MainNavigationViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // create a vc and add to scrollview
        // create an instance of the view controller
        let cameraScreenViewController = CameraScreenViewController(nibName: "CameraScreenViewController", bundle: nil)
        
        self.addChildViewController(cameraScreenViewController)
        self.scrollView.addSubview(cameraScreenViewController.view)
        // the view controller moved to this parent view controller
        cameraScreenViewController.didMove(toParentViewController: self)
        
        // for the second view controller
        let restaurantListViewController = RestaurantListViewController(nibName: "RestaurantListViewController", bundle: nil)
        
        // get the frame(size of the device) of the view
        var right1Frame = restaurantListViewController.view.frame
        // set it all the way to the right
        right1Frame.origin.x = self.view.frame.size.width
        restaurantListViewController.view.frame =  right1Frame
        
        self.addChildViewController(restaurantListViewController)
        self.scrollView.addSubview(restaurantListViewController.view)
        // the view controller moved to this parent view controller
        restaurantListViewController.didMove(toParentViewController: self)
        
        
        // for the third view controller
        let userDetailViewController = UserDetailViewController(nibName: "UserDetailViewController", bundle: nil)
        
        // get the frame(size of the device) of the view
        var right2Frame = userDetailViewController.view.frame
        // set it all the way to the right
        right2Frame.origin.x = self.view.frame.size.width * 2
        userDetailViewController.view.frame =  right2Frame
        
        self.addChildViewController(userDetailViewController)
        self.scrollView.addSubview(userDetailViewController.view)
        // the view controller moved to this parent view controller
        userDetailViewController.didMove(toParentViewController: self)
        
        
        // set the content size of our scroll view, 66 to overlap the navigation view controller
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width * 3, height: self.view.frame.size.height - 66)
        
        // start at the second screen
        self.scrollView.contentOffset = CGPoint(x: self.view.frame.size.width, y: 0)
        
        
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
