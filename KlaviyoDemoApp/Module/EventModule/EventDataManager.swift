//
//  EventDataManager.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/10/22.
//

import Foundation
import UIKit

struct DynamicCodingKeys: CodingKey {

    // Use for string-keyed dictionary
    var stringValue: String
    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    // Use for integer-keyed dictionary
    var intValue: Int?
    init?(intValue: Int) {
        // We are not using this, thus just return nil
        return nil
    }
}

struct PostEventReqInfo: Codable {
    let token: String
    let event: String
    let customer_properties: CustomerProperty
    let properties: Properties

    init(token: String,
         event: String,
         customerProperty: CustomerProperty,
         properties: Properties) {
        self.token = token
        self.event = event
        self.customer_properties = customerProperty
        self.properties = properties
    }
}

struct CustomerProperty: Codable {
    //SpecialField
    let email: String
    var first_name: String?
    var last_name: String?
    var phone_number: String?
    var city: String?
    var region: String?
    var country: String?
    var zip: String?
    var image: String?
    var consent: [String]?
    let extraParameter: [String: String]?

    init(email: String, extraParameter: [String: String]? = nil) {
        self.email = email
        self.extraParameter = extraParameter
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DynamicCodingKeys.self)
        try container.encode(email, forKey: DynamicCodingKeys(stringValue: "$email")!)
        if let extraPara = extraParameter {
            for (extraKey, extraValue) in extraPara {
                try container.encode(extraValue, forKey: DynamicCodingKeys(stringValue: extraKey)!)
            }
        }
    }
}

struct Properties: Codable {
    let item_name: String
    let value: Int
    let extraParameter: [String: String]?

    init(itemName: String, value: Int, extraParameter: [String: String]? = nil) {
        self.item_name = itemName
        self.value = value
        self.extraParameter = extraParameter
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DynamicCodingKeys.self)
        try container.encode(value, forKey: DynamicCodingKeys(stringValue: "$value")!)
        if let extraPara = extraParameter {
            for (extraKey, extraValue) in extraPara {
                try container.encode(extraValue, forKey: DynamicCodingKeys(stringValue: extraKey)!)
            }
        }
    }
}


struct EventResponse: Decodable {
}

protocol EventDataManaging {
    func postEvent(event: EventInfo)
}

class EventDataManager: EventDataManaging {

    let networkManager: Networking

    init(networkManager: Networking) {
        self.networkManager = networkManager
    }

    func postEvent(event: EventInfo) {
        self.postEvent(event: event) { _ in }
    }

    func postEvent(event: EventInfo,
                     callBack: @escaping (Result<Data, Failure>) -> Void) {

        let customerProperty = Helper.getCustomerProperty(extraParameter: ["extraKey": "ectraValue"])
        let properties = Properties(itemName: event.item,
                                          value: event.value,
                                          extraParameter: ["extraKey1": "extraValue1"])

        let eventInfo = PostEventReqInfo(token: Global.apiKey,
                                         event: event.event,
                                         customerProperty: customerProperty,
                                         properties: properties)

        let request = KlaviyoRequest.eventPost(event: eventInfo)
        self.networkManager.request(request: request, callBack: callBack)
    }
}
