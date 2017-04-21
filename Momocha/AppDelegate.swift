//
//  AppDelegate.swift
//  Momocha
//
//  Created by samman on 3/1/17.
//  Copyright © 2017 keema. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Here we will go through all the things that our app will need to do after launching
        // To reference our window
        
        let loggedIn = false
        
        let configuration = ParseClientConfiguration(block: { (configuration: ParseMutableClientConfiguration) -> Void in
            configuration.applicationId = "momochaID"
            configuration.clientKey = "381389"  // set to nil assuming you have not set clientKey
            configuration.server = "https://momocha.herokuapp.com/parse"
        })
        
        // Parse.initializeWithConfiguration(configuration)
        
        // Parse.initialize()
        
        // Parse.init(with: configuration)
        
        // Parse.initializeWithConfiguration(configuration)
        
        // For starting the UI screen
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // storyboard = Blueprint for how to build your app, so reference it; Main is the default that was built
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // build a navigation controller
        let diplayNavigationController = storyboard.instantiateViewController(withIdentifier: "MomoNavigationController") as! UINavigationController
        diplayNavigationController.tabBarItem.title = "Display data"
        diplayNavigationController.tabBarItem.image = #imageLiteral(resourceName: "cross")
        
        // set the endpoint class variable as required
        
        // for the top rated tab, create a navigation controller, view controller, and an endpoint
        let cameraNavigationController = storyboard.instantiateViewController(withIdentifier: "CameraNavigationController") as! UINavigationController
        cameraNavigationController.tabBarItem.title = "Camera"
        cameraNavigationController.tabBarItem.image = #imageLiteral(resourceName: "take-photo")
        
        // initialize a tabbar and set the default
        let restaurantsTabBarController = UITabBarController()
        
        // list all the viewControllers
        restaurantsTabBarController.viewControllers = [cameraNavigationController, diplayNavigationController]
        
        // start the window with a root view
        
        if loggedIn {
            window?.rootViewController = restaurantsTabBarController
        } else {
            // let experimentalNavigationViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")

            let experimentalNavigationViewController = storyboard.instantiateViewController(withIdentifier: "ExpNavigationController") as! UINavigationController
            //storyboard.instantiateViewController(withIdentifier: "CameraNavigationController") as! UINavigationController
            
            let nextTabBarController = UITabBarController()
            
            nextTabBarController.viewControllers = [experimentalNavigationViewController]
            window?.rootViewController = nextTabBarController
        }
        
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

