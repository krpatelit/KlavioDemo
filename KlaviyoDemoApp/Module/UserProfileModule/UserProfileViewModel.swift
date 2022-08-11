//
//  UserProfileViewModel.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/10/22.
//

import Foundation

protocol UserProfileViewModeling {
    var eventList: [ProfileEvent] { get }
    var updateUI: (() -> Void)? { get set}
    var showMessage: ((_ title: String, _ message: String?) -> Void)? { get set }
    func fetchList()
}

class Pagination {
    var cursor: String?
    var count: String = "50"
    var sort: String = "desc"
}

class UserProfileViewModel: UserProfileViewModeling {

    let dataManager: UserProfileDataManaging
    private(set) var eventList = [ProfileEvent]()
    let pagination = Pagination()
    var updateUI: (() -> Void)?
    var showMessage: ((_ title: String, _ message: String?) -> Void)?

    init(dataManager: UserProfileDataManaging) {
        self.dataManager = dataManager
    }

    func fetchList() {
        self.dataManager.fetchEventList(pagination: self.pagination) { [weak self] result in
            guard let self = self else { return }
            print(result)
            switch result {
            case .success(let userProfileList):
                self.eventList = userProfileList.data
                self.pagination.cursor = userProfileList.next
                self.updateUI?()
                break
            case .failure(let error):
                //handle Error
                print(error)
                self.showMessage?("Error!", "Fetch Event failed")
                break
            }
        }
    }
}
