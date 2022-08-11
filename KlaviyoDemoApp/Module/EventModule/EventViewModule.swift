//
//  EventViewModule.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/10/22.
//

import Foundation

protocol EventViewModeling {
    func buttonEvent(event: String)
}

class EventViewModule: EventViewModeling {

    let dataManager: EventDataManaging

    init(dataManager: EventDataManaging) {
        self.dataManager = dataManager
    }

    func buttonEvent(event: String) {
        self.dataManager.buttonEvent(event: event) { result in
            //handle Error or Success here
        }
    }

}
