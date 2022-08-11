//
//  TabBarCoordinator.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/9/22.
//

import Foundation
import UIKit

class TabBarCoordinator: Coordinator {

    var parent: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    let tabBarController: UITabBarController
    let networkManager: Networking

    required init(_ navigationController: UINavigationController,
                  parent: Coordinator?,
                  networkManager: Networking) {
        self.navigationController = navigationController
        self.parent = parent
        self.tabBarController = UITabBarController()
        self.networkManager = networkManager
    }

    func start() {
        let eventCoordinator = EventCoordinator(self.navigationController,
                                                parent: self,
                                                networkManager: networkManager)

        children.append(eventCoordinator)
        eventCoordinator.start()

        let userCoordinator = UserProfileCoordinator(self.navigationController,
                                                     parent: self,
                                                     networkManager: self.networkManager)

        children.append(userCoordinator)
        userCoordinator.start()

        let eventVC = eventCoordinator.rootViewContoller!
        let userVC = userCoordinator.rootViewContoller!

        let vcList = [eventVC, userVC]
        self.tabBarController.setViewControllers(vcList, animated: false)

        self.navigationController.setViewControllers([self.tabBarController], animated: false)
        self.navigationController.isNavigationBarHidden = true
    }

    func childDidFinish(_ child: Coordinator?) {
        if let index = children.firstIndex(where: { $0 === child }) {
            children.remove(at: index)
        }
    }
}
