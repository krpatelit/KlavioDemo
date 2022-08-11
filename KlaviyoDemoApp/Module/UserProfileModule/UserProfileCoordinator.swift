//
//  UserProfileCoordinator.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/9/22.
//

import Foundation
import UIKit

class UserProfileCoordinator: Coordinator {

    var parent: Coordinator?
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "UserProfileViewController") as? UserProfileViewController

        let dataManager = UserProfileDataManager(networkManager: self.networkManager)
        let eventModel = UserProfileViewModel(dataManager: dataManager)
        viewController?.viewModele = eventModel

        rootViewContoller = UINavigationController(rootViewController: viewController!)
        
    }

    func childDidFinish(_ child: Coordinator?) {
        if let index = children.firstIndex(where: { $0 === child }) {
            children.remove(at: index)
        }
    }
}
