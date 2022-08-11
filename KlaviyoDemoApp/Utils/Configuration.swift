//
//  GlobalVariables.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/10/22.
//

import Foundation

//This is for demo purpose only
class Global {
    static var user = User()
    static let apiKey = "pk_96b0fe8936212b7aa32e67897b086660e8"
}

//This is only for demo purpose, Ideally data should be coming from DB
class User {
    var emailId: String = "kiran@klaviyo.com" {
        didSet {
            if emailId != oldValue {
                self.updateToDB()
                NotificationCenter.default.post(name: .profileChange, object: nil)
            }
        }
    }
    var userId: String = ""//"01GA5DD0W1BW1SAFX3CRD5K4PK"
    let first_name: String? = nil
    let last_name: String? = nil
    let phone_number: String? = nil
    let city: String? = nil
    let region: String? = nil
    let country: String? = nil
    let zip: String? = nil
    let image: String? = nil
    let consent: [String]? = nil

    //This is demo purpose only
    init() {
        let emailKey = "user.emailId"
        if let email = UserDefaults.standard.string(forKey: emailKey) {
            self.emailId = email
        }
    }

    //This is only for demo purpose, Ideally this should be DB value
    func updateToDB() {
        let stadard = UserDefaults.standard
        let emailKey = "user.emailId"
        stadard.set(self.emailId, forKey: emailKey)
    }
}

