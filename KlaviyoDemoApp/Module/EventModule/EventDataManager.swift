//
//  EventDataManager.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/10/22.
//

import Foundation
import UIKit

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
