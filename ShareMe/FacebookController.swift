//
//  FacebookController.swift
//  ShareMe
//
//  Created by Florian VIDAL on 08/10/2016.
//  Copyright © 2016 Florian VIDAL. All rights reserved.
//

import Foundation

class FacebookController: UIViewController, FBSDKLoginButtonDelegate{
    
    @IBOutlet var FacebookView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            
            if (FBSDKAccessToken.current() != nil)
            {
                // User is already logged in, do work such as go to next view controller.
                
                // Or Show Logout Button
                let loginView : FBSDKLoginButton = FBSDKLoginButton()
                self.view.addSubview(loginView)
                loginView.center = self.view.center
                loginView.readPermissions = ["public_profile", "email", "user_friends"]
                loginView.delegate = self
                self.returnUserData()
            }
            else
            {
                let loginView : FBSDKLoginButton = FBSDKLoginButton()
                self.view.addSubview(loginView)
                loginView.center = self.view.center
                loginView.readPermissions = ["public_profile", "email", "user_friends"]
                loginView.delegate = self
                self.returnUserData()
            }
            
        }
        
        // Facebook Delegate Methods
        
        func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
            print("User Logged In")
            self.returnUserData()
//            print("User Name is: \(result)")
//            let userName : NSString = result.value(forKey: "name") as! NSString
//            print("User Name is: \(userName)")
            
            if ((error) != nil)
            {
                // Process error
            }
            else if result.isCancelled {
                // Handle cancellations
            }
            else {
                // If you ask for multiple permissions at once, you
                // should check if specific permissions missing
                if result.grantedPermissions.contains("email")
                {
                    let userName : NSString = result.value(forKey: "name") as! NSString
                    print("User Name is: \(userName)")
                }
                
                self.returnUserData()
            }
            
        }
        
        func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
            print("User Logged Out")
        }
        
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
               
            }
            else
            {
                print("fetched user: \(result)")
            }
        })
    }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
}
