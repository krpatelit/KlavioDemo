//
//  HelperUtility.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/11/22.
//

import Foundation

class Helper {

    static func getCustomerProperty(extraParameter: [String: String]? = nil) -> CustomerProperty {
        let user = Global.user
        var customerProperty = CustomerProperty(email: user.emailId,
                                                extraParameter: extraParameter)
        customerProperty.phone_number = user.phone_number
        customerProperty.first_name = user.first_name
        customerProperty.last_name = user.last_name
        customerProperty.city = user.city
        customerProperty.region = user.region
        customerProperty.country = user.country
        customerProperty.zip = user.zip
        customerProperty.image = user.image
        return customerProperty
    }
}
