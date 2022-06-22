//
//  AppDelegate.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 21/6/22.
//

import UIKit
import Swinject
import SwinjectStoryboard

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        Application.shared.startApp(mainWindow: window!)
                
        return true
    }

    /**
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
     - Parameter application: cs_ld current app singleton
    */
    func applicationWillResignActive(_ application: UIApplication) {
    }

    /**
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     - Parameter application: cs_ld current app singleton
     */
    func applicationDidEnterBackground(_ application: UIApplication) {
        window?.endEditing(true)
    }

    /**
     Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
     - Parameter application: cs_ld current app singleton
    */
    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    /**
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     - Parameter application: cs_ld current app singleton
    */
    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    /**
     Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
     - Parameter application: cs_ld current app singleton
    */
    func applicationWillTerminate(_ application: UIApplication) {
    }


}

//// MARK: - AppDelegate extension
extension AppDelegate {
    /// Shared application delegate
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate // swiftlint:disable:this force_cast
    }

    /// Application root view controller
    var rootViewController: RootViewController {
        return window!.rootViewController as! RootViewController // swiftlint:disable:this force_cast
    }
}

