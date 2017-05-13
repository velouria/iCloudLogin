//
//  ViewController.swift
//  iCloudLogin
//
//  Created by Catarina Simões on 16/11/14.
//  Copyright (c) 2014 velouria.org. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var cloudManager: CloudManager?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cloudManager = CloudManager()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Action to be called when the user taps "login with iCloud"
    @IBAction func iCloudLoginAction() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        self.iCloudLogin({ (success) -> () in
            if success {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                viewController.user = self.user
                self.present(viewController, animated: false, completion: nil)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            } else {
                // TODO error handling
            }
        })
    }
    
    // Nested CloudKit requests for permission; for getting user record and user information.
    fileprivate func iCloudLogin(_ completionHandler: @escaping (_ success: Bool) -> ()) {
        self.cloudManager!.requestPermission { (granted) -> () in
            if !granted {
                let iCloudAlert = UIAlertController(title: "iCloud Error", message: "There was an error connecting to iCloud. Check iCloud settings by going to Settings > iCloud.", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                
                iCloudAlert.addAction(okAction)
                self.present(iCloudAlert, animated: true, completion: nil)
            } else {
                self.cloudManager!.getUser({ (success, user) -> () in
                    if success {
                        self.user = user
                        self.cloudManager!.getUserInfo(self.user!, completionHandler: { (success, user) -> () in
                            if success {
                                completionHandler(true)
                            }
                        })
                    } else {
                        // TODO error handling
                    }
                })
            }
        }
    }
    
}
