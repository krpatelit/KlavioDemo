//
//  KlaviyoRequest.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/9/22.
//

import Foundation

enum KlaviyoRequest: RequestProtocol, CustomStringConvertible {

    case eventPost(event: EventData)
    case eventList(reqInfo: EventListReqInfo)
    case profileId(reqInfo: ProfileIdReqInfo)

    var domain: String {
        return "https://a.klaviyo.com/api"
    }

    var url: String {
        switch self {
        case .eventPost(_):
            return self.domain + "/track"
        case .eventList(let reqInfo):
            //"https://a.klaviyo.com/api/v1/person/01GA5DD0W1BW1SAFX3CRD5K4PK/metrics/timeline?count=5&sort=desc&api_key=pk_96b0fe8936212b7aa32e67897b086660e8"
            var urlString = self.domain
            urlString += "/v1/person/" + reqInfo.personId + "/metrics/timeline?"
            urlString += "count=\(reqInfo.count)"
            urlString += "&sort=\(reqInfo.sort)"
            urlString += "&api_key=\(reqInfo.apiKey)"
            return urlString
        case .profileId(let reqInfo):
            var urlString = self.domain
            urlString += "/v2/people/search?"
            if let email = reqInfo.email {
                urlString += "email=\(email)"
            } else if let phone_number = reqInfo.phone_number {
                urlString += "phone_number=\(phone_number)"
            } else if let external_id = reqInfo.external_id {
                urlString += "external_id=\(external_id)"
            }
            urlString += "&api_key=\(reqInfo.apiKey)"
            return urlString
        }
    }

    var description: String {
        return "\(self.url)"
    }

    var method: String {
        switch self {
        case .eventPost:
            return "POST"
        case .eventList(_), .profileId(_):
            return "GET"
        }
    }

    var headers: [String: String]? {
        switch self {
        case .eventPost(_):
            return ["Accept": "text/html", "Content-Type": "application/json"]
        case .eventList(_), .profileId(_):
            return ["Accept": "application/json"]
        }
    }

    var postBody: Data? {
        switch self {
        case .eventPost(let event):
            let data = try? JSONEncoder().encode(event)
            return data
        default:
            return nil
        }
    }

}
