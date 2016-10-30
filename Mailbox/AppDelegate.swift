//
//  AppDelegate.swift
//  Mailbox
//
//  Created by Chris Argonish on 10/25/16.
//  Copyright © 2016 Chris. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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

    /***  3D Touch (Handle Quick Actions) ***/
    
    private func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        let handledShortCutItem = handleShortCutItem(shortcutItem: shortcutItem)
        
        //the line below calls our handledShortCutItem func
        completionHandler(handledShortCutItem)
    }
    
    func handleShortCutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        // this is where we define what happens when we click on a shortcut. see if we can direct the user to a screen to compose a message
        let alertController = UIAlertController(title: "Shortcut Action", message: "\"\(shortcutItem.localizedTitle)\"", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        window!.rootViewController?.present(alertController, animated: true, completion: nil)
        
//        for performSegue
//        Get root navigation viewcontroller and its first controller
//        let rootNavigationViewController = window!.rootViewController as? UINavigationController
//        let rootViewController = rootNavigationViewController?.viewControllers.first as UIViewController?
//        
//        Pop to root view controller so that approperiete segue can be performed
//        rootNavigationViewController?.popToRootViewControllerAnimated(false)
//        
//        switch shortcutType {
//        case .View1:
//            handled = true
//        case.View2:
//            rootViewController?.performSegueWithIdentifier("toView2", sender: nil)
//            handled = true
//        }
//    }
    
        return true
    }
}



