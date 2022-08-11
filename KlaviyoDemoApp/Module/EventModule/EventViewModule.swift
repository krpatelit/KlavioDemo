//
//  EventViewModule.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/10/22.
//

import Foundation

protocol EventViewModeling {
    func postEvent(event: EventInfo)
}

class EventViewModule: EventViewModeling {

    let dataManager: EventDataManaging

    init(dataManager: EventDataManaging) {
        self.dataManager = dataManager
    }

    func postEvent(event: EventInfo) {
        self.dataManager.postEvent(event: event)
    }
}
