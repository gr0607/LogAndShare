//
//  AppDelegate.swift
//  LogAndShare
//
//  Created by admin on 03.02.2021.
//


import UIKit
import FBSDKCoreKit
import VK_ios_sdk
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate  {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ApplicationDelegate.shared.application( application, didFinishLaunchingWithOptions: launchOptions)
        
        GIDSignIn.sharedInstance().clientID = "542472326428-aopjd3huoesdh1q7lslrlciifk26emn7.apps.googleusercontent.com"
        
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        return true
    }
    
   
          
    func application( _ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        ApplicationDelegate.shared.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        GIDSignIn.sharedInstance().handle(url)
        
        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        return true
    }
    
  
}

