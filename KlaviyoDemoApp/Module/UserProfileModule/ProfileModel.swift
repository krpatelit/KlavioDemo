//
//  ProfileModel.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/11/22.
//

import Foundation

struct EventListReqInfo: Encodable {
    let personId: String
    let since: String
    let count: String
    let sort: String
    let apiKey: String
}

struct ProfileIdReqInfo: Encodable {
    let email: String?
    let phone_number: String?
    let external_id: String?
    let apiKey: String
}

struct ProfileIdResponse: Decodable {
    let id: String
}

struct ProfileEventList: Decodable {
    let count: Int
    let data: [ProfileEvent]
    let next: String?
}

//As require, we may add extra field
struct ProfileEvent: Decodable {
    let object: String
    let id: String
    let statistic_id: String
    let event_name: String
    let event_properties: EventProperty?
    let datetime: String
}

struct EventProperty: Decodable {
    let item_name: String?
    let value: String?

    enum CodingKeys: String, CodingKey {
        case item_name
        case value = "$value"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.item_name = try container.decodeIfPresent(String.self,
                                                   forKey: .item_name)
        let val = try? container.decodeIfPresent(Int.self,
                                                   forKey: .value)
        if let val = val {
            self.value = String(val)
        } else {
            self.value = ""
        }

    }
    
}
