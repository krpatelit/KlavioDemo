//
//  ApplicationCoordinator.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/9/22.
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {

    var parent: Coordinator?
    var children: [Coordinator] = []
    var window: UIWindow
    var navigationController: UINavigationController

    required init(_ window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
    }

    lazy var networkManager: Networking = {
        NetworkManager()
    }()

    func start() {

        UINavigationBar.appearance().tintColor = UIColor.purple
        //UITabBar.appearance().backgroundColor = UIColor.lightGray
        UITabBar.appearance().tintColor = UIColor.black
        //UINavigationBar.appearance().backgroundColor = UIColor.lightGray


        let coordinator = TabBarCoordinator(navigationController,
                                            parent: self,
                                            networkManager: self.networkManager)
        children.append(coordinator)
        coordinator.start()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func childDidFinish(_ child: Coordinator?) {
        if let index = children.firstIndex(where: { $0 === child }) {
            children.remove(at: index)
        }
    }
}
