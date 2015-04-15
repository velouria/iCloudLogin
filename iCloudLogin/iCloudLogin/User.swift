//
//  User.swift
//  iCloudLogin
//
//  Created by Catarina Simões on 16/11/14.
//  Copyright (c) 2014 velouria.org. All rights reserved.
//

import CloudKit

class User: NSObject {
   
    var userRecordID: CKRecordID
    var firstName: String?
    var lastName: String?
    
    
    init(userRecordID: CKRecordID) {
        self.userRecordID = userRecordID
    }

}

