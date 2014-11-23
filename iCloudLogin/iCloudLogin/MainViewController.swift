//
//  ViewController.swift
//  iCloudLogin
//
//  Created by Catarina Simões on 16/11/14.
//  Copyright (c) 2014 velouria.org. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var loggedInLabel: UILabel?
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(Bool) {
        loggedInLabel!.text = "Welcome \(user!.firstName!) \(user!.lastName!)!"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
