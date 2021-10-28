//
//  VKManager.swift
//  LogAndShare
//
//  Created by admin on 06.02.2021.
//

import Foundation
import VK_ios_sdk

class VKManager: NSObject, VKSdkDelegate, VKSdkUIDelegate {
   
    private var vkSdk : VKSdk
    private var viewController: LoginViewController?
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: "7752908")
        super.init()
        print("VKSdk.initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }

    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            print(result.state.rawValue)
           
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                self.viewController?.performSegue(withIdentifier: "first", sender: nil)
               }
            
           print("hello")
        } else {
            print("sorry")
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        if (viewController?.presentedViewController != nil) {
            viewController?.dismiss(animated: true, completion: {
                self.viewController?.present(controller, animated: true, completion: {
                      })
                  })
              } else {
                viewController?.present(controller, animated: true, completion: {
                  })
              }
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
   
    
    func vkLogin(from viewController: LoginViewController) {
        self.viewController = viewController
        let scope = ["wall", "friends","photos"]
         VKSdk.wakeUpSession(scope) {(state, error) in
             switch state {
             case .initialized:
                 print("initialized")
                VKSdk.authorize(scope)
            case .authorized:
                 print("autorized")
          
             default:
                 print("oops")
             }
         }
    }
}
