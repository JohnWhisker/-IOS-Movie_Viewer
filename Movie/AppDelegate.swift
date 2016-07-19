//
//  AppDelegate.swift
//  Movie
//
//  Created by John Whisker on 7/2/16.
//  Copyright © 2016 John Whisker. All rights reserved.
//

import UIKit
import ARSLineProgress
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    override init() {
        FIRApp.configure()
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // Now Playing Tab
        let nowPlayingNavigationController = storyboard.instantiateViewControllerWithIdentifier("MovieNavigationController") as! UINavigationController
        let nowPlayingViewController = nowPlayingNavigationController.topViewController as! MovieViewController
        nowPlayingViewController.endpoint = "now_playing"
        nowPlayingViewController.title = "Now Playing"
        nowPlayingViewController.tabBarItem.title = "Now Playing"
        nowPlayingViewController.tabBarItem.image = UIImage(named: "nowPlaying")
        
        // Top Rated Tab
        let topRateNavigationController = storyboard.instantiateViewControllerWithIdentifier("MovieNavigationController") as! UINavigationController
        let topRateViewController = topRateNavigationController.topViewController as! MovieViewController
        topRateViewController.endpoint = "top_rated"
        topRateViewController.title = "Top Rated"
        topRateViewController.tabBarItem.title = "Top Rated"
        topRateViewController.tabBarItem.image = UIImage(named: "top")
        
        // Search Bar
        let searchNavigationController = storyboard.instantiateViewControllerWithIdentifier("SearchNavigationController") as! UINavigationController
        _ = searchNavigationController.topViewController as! SearchViewController
       // topRateViewController.endpoint = "top_rated"
       // searchViewController.title = "Search"
        //searchViewController.tabBarItem.title = "Search"
        searchNavigationController.tabBarItem.title = "Seach"
        searchNavigationController.setToolbarHidden(true, animated: false)
        
        //topRateViewController.tabBarItem.image = UIImage(named: "top")

        
        // Init Tab Bar
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [nowPlayingNavigationController,topRateNavigationController,searchNavigationController]
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

