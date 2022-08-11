//
//  EventDataManager.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/10/22.
//

import Foundation
import UIKit
/*
{
  "token": "PUBLIC_KEY",
  "event": "Ordered Product",
  "customer_properties": {
    "$email": "abraham.lincoln@klaviyo.com"
  },
  "properties": {
    "item_name": "Boots",
    "$value": 100
  }
}
*/

struct EventData: Codable {
    let token: String
    let event: String
    let customer_properties: CustomerProperty
    let properties: Properties

    init(token: String, event: String, email: String) {
        self.token = token
        self.event = event
        self.customer_properties = CustomerProperty(email: email)
        self.properties = Properties(itemName: "Test", value: 111)
    }
}

struct CustomerProperty: Codable {
    let email: String

    enum CodingKeys: String, CodingKey {
        case email = "$email"
    }

    init(email: String) {
        self.email = email
    }
}

struct Properties: Codable {
    let item_name: String
    let value: Int

    enum CodingKeys: String, CodingKey {
        case item_name = "item_name"
        case value = "$value"
    }

    init(itemName: String, value: Int) {
        self.item_name = itemName
        self.value = value
    }
}


struct EventResponse: Decodable {
}

protocol EventDataManaging {
    func buttonEvent(event: String)
    func buttonEvent(event: String,
                     callBack: @escaping (Result<Data, Failure>) -> Void)
}

class EventDataManager: EventDataManaging {

    let networkManager: Networking

    init(networkManager: Networking) {
        self.networkManager = networkManager
    }

    func buttonEvent(event: String) {
        self.buttonEvent(event: event) { _ in }
    }

    func buttonEvent(event: String,
                     callBack: @escaping (Result<Data, Failure>) -> Void) {

        let eventData = EventData(token: Global.apiKey,
                                  event: event,
                                  email: Global.user.emailId)

        let request = KlaviyoRequest.eventPost(event: eventData)
        self.networkManager.request(request: request, callBack: callBack)
    }
}
