//
//  EventCoordinator.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/9/22.
//

import Foundation
import UIKit

class EventCoordinator: Coordinator {

    weak var parent: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    var rootViewContoller: UINavigationController?
    let networkManager: Networking

    required init(_ navigationController: UINavigationController,
                  parent: Coordinator?,
                  networkManager: Networking) {
        self.navigationController = navigationController
        self.parent = parent
        self.networkManager = networkManager
    }

    func start() {
        let viewController = Storyboardable<EventViewController>.main.instantiate
        let dataManager = EventDataManager(networkManager: self.networkManager)
        let eventModel = EventViewModule(dataManager: dataManager)
        viewController.viewModule = eventModel
        rootViewContoller = UINavigationController(rootViewController: viewController)
    }

    func childDidFinish(_ child: Coordinator?) {
        if let index = children.firstIndex(where: { $0 === child }) {
            children.remove(at: index)
        }
    }
}
