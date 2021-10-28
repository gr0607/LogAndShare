//
//  ViewController.swift
//  LogAndShare
//
//  Created by admin on 03.02.2021.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import VK_ios_sdk
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInDelegate {
    
  
    private let fbManager = FBMmanager()
    private var vkManager : VKManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vkManager = VKManager()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().presentingViewController = self
    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        switch sender.tag {
            case 0 : fbManager.fbLogin(from: self)
        case 1: vkManager?.vkLogin(from: self)
        case 2:  GIDSignIn.sharedInstance()?.signIn()
            default:
                print("default")
        }
    }
//MARK: - work with google
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
      if let error = error {
        if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
          print("The user has not signed in before or they have since signed out.")
        } else {
          print("\(error.localizedDescription)")
        }
        return
      } else {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.performSegue(withIdentifier: "first", sender: nil)
        }
      }
        
    }
    
}

