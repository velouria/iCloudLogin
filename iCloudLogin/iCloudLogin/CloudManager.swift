//
//  CloudManager.swift
//  iCloudLogin
//
//  Created by Catarina Simões on 16/11/14.
//  Copyright (c) 2014 velouria.org. All rights reserved.
//

import CloudKit

class CloudManager: NSObject {
    
    var defaultContainer: CKContainer?
    
    override init() {
        defaultContainer = CKContainer.default()
    }
    
    func requestPermission(_ completionHandler: @escaping (_ granted: Bool) -> ()) {
        defaultContainer!.requestApplicationPermission(CKApplicationPermissions.userDiscoverability, completionHandler: { applicationPermissionStatus, error in
            if applicationPermissionStatus == CKApplicationPermissionStatus.granted {
                completionHandler(true)
            } else {
                // very simple error handling
                completionHandler(false)
            }
        })
    }
    
    func getUser(_ completionHandler: @escaping (_ success: Bool, _ user: User?) -> ()) {
        defaultContainer!.fetchUserRecordID { (userRecordID, error) in
            if error != nil {
                completionHandler(false, nil)
            } else {
                let privateDatabase = self.defaultContainer!.privateCloudDatabase
                privateDatabase.fetch(withRecordID: userRecordID!, completionHandler: { (user: CKRecord?, anError) -> Void in
                    if (error != nil) {
                        completionHandler(false, nil)
                    } else {
                        let user = User(userRecordID: userRecordID!)
                        completionHandler(true, user)
                    }
                })
            }
        }
    }
    
    func getUserInfo(_ user: User, completionHandler: @escaping (_ success: Bool, _ user: User?) -> ()) {
        defaultContainer!.discoverUserIdentity(withUserRecordID: user.userRecordID, completionHandler: { (userIdentity, error) in
            if error != nil {
                completionHandler(false, nil)
            } else {
                user.firstName = userIdentity!.nameComponents!.givenName
                user.lastName = userIdentity!.nameComponents!.familyName
                completionHandler(true, user)
            }
        })
    }
    
}
