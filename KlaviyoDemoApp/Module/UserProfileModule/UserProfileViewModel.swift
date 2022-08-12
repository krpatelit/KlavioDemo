//
//  UserProfileViewModel.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/10/22.
//

import Foundation

class Pagination {
    enum SortEvent: String {
        case asc
        case desc
    }
    var cursor: String?
    var count: String = "10"
    var sort: String = SortEvent.desc.rawValue
    var hasMoreData: Bool = true
    var isLoading: Bool = false

    func isNewDataPager() -> Bool {
        sort == SortEvent.asc.rawValue
    }
}

struct EventCellViewModel {
    let event: String
    let item: String?
    let price: String?
    let date: String?
}

protocol UserProfileViewModeling {
    var eventList: [ProfileEvent] { get }
    var updateUI: (() -> Void)? { get set}
    var showMessage: ((_ title: String, _ message: String?) -> Void)? { get set }
    func loadNewData()
    func loadMoreData()
    func resetData()
    func item(at index: Int) -> EventCellViewModel
    func numberOfItem() -> Int

}

class UserProfileViewModel: UserProfileViewModeling {

    let dataManager: UserProfileDataManaging
    private(set) var eventList = [ProfileEvent]()
    let oldEventPager = Pagination()
    let newEventPager = Pagination()
    var updateUI: (() -> Void)?
    var showMessage: ((_ title: String, _ message: String?) -> Void)?

    init(dataManager: UserProfileDataManaging) {
        self.dataManager = dataManager
    }

    private func resetPager() {
        newEventPager.sort = Pagination.SortEvent.asc.rawValue
        newEventPager.cursor = String(Date().timeIntervalSince1970)
        oldEventPager.cursor = nil
        oldEventPager.hasMoreData = true
    }

    func numberOfItem() -> Int {
        self.eventList.count
    }

    func item(at index: Int) -> EventCellViewModel {
        let event = self.eventList[index]
        let viewModel = EventCellViewModel(event: event.event_name,
                           item: event.event_properties?.item_name,
                           price: event.event_properties?.value,
                           date: event.datetime)
        return viewModel
    }

    func resetData() {
        self.resetPager()
        eventList = [ProfileEvent]()
        self.updateUI?()
    }

    func loadNewData() {
        self.fetchList(pagination: newEventPager)
    }

    func loadMoreData() {
        if oldEventPager.hasMoreData && !oldEventPager.isLoading {
            oldEventPager.isLoading = true
            self.fetchList(pagination: oldEventPager)
        }
    }

    func fetchList(pagination: Pagination) {
        self.dataManager.fetchEventList(pagination: pagination) { [weak self] result in
            guard let self = self else { return }
            print(result)
            switch result {
            case .success(let eventData):
                self.updateDate(pagination: pagination, eventData: eventData)
                break
            case .failure(let error):
                //handle Error
                print(error)
                self.showMessage?("Error!", "Fetch Event failed")
                break
            }
        }
    }

    private func updateDate(pagination: Pagination, eventData: ProfileEventList) {
        pagination.cursor = eventData.next
        if pagination.isNewDataPager() {
            if pagination.cursor == nil {
                pagination.cursor = String(Date().timeIntervalSince1970)
                print("Pagination Set New Cursor \(pagination.cursor ?? "")")
            }
            self.eventList.insert(contentsOf: eventData.data.reversed(), at: 0)
        } else {
            self.eventList.append(contentsOf: eventData.data)
            if pagination.cursor == nil {
                oldEventPager.hasMoreData = false
            }
        }
        pagination.isLoading = false
        self.updateUI?()
    }
}
