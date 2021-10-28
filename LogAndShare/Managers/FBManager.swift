//
//  FBManager.swift
//  LogAndShare
//
//  Created by admin on 06.02.2021.
//

import Foundation
import FBSDKLoginKit


class FBMmanager {
    
    func fbLogin(from viewController: UIViewController) {
        let fbManager = FBSDKLoginKit.LoginManager()
        
        fbManager.logIn(permissions: ["public_profile", "email"], from: viewController) { (result, error) in
            guard error == nil else {
                            print(error!.localizedDescription)
                            return
                        }
                                               
                        guard let result = result, !result.isCancelled else {
                            print("User cancelled login")
                            return
                        }
            //0.3 work with simulator; work with 0.2 on device; 0.1 is not work
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    viewController.performSegue(withIdentifier: "first", sender: nil)
            }
        }
    }
    
}
