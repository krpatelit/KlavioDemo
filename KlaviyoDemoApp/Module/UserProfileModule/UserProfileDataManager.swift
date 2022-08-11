//
//  UserProfileDataManager.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/10/22.
//

import Foundation

struct EventListReqInfo: Encodable {
    let personId: String
    let since: String
    let count: String
    let sort: String
    let apiKey: String
}

struct ProfileIdReqInfo: Encodable {
    let email: String?
    let phone_number: String?
    let external_id: String?
    let apiKey: String
}

struct ProfileIdResponse: Decodable {
    let id: String
}

struct ProfileEventList: Decodable {
    let count: Int
    let data: [ProfileEvent]
    let next: String?
}

//As require, we may add extra field
struct ProfileEvent: Decodable {
    let object: String
    let id: String
    let statistic_id: String
    let event_name: String
    //let event_properties: String
    let datetime: String
}

protocol UserProfileDataManaging {
    func fetchEventList(pagination: Pagination,
                        callBack: @escaping (Result<ProfileEventList, Failure>) -> Void)
}

class UserProfileDataManager: UserProfileDataManaging {

    let networkManager: Networking

    init(networkManager: Networking) {
        self.networkManager = networkManager
    }

    func fetchEventList(pagination: Pagination,
                        callBack: @escaping (Result<ProfileEventList, Failure>) -> Void) {

        Task {
            let userId = await self.getUserId()
            let listInfo = EventListReqInfo(personId: userId,
                                            since: pagination.cursor ?? "",
                                            count: pagination.count,
                                            sort: pagination.sort,
                                            apiKey: Global.apiKey)

            let request = KlaviyoRequest.eventList(reqInfo: listInfo)
            self.networkManager.request(request: request, callBack: callBack)
        }
    }

    private func getUserId() async -> String {

        if !Global.user.userId.isEmpty {
            return Global.user.userId
        }

        let reqInfo = ProfileIdReqInfo(email: Global.user.emailId,
                                        phone_number: nil,
                                        external_id: nil,
                                        apiKey: Global.apiKey)

        let request = KlaviyoRequest.profileId(reqInfo: reqInfo)

        return await withCheckedContinuation { continuation in

            let resBlock: (Result<ProfileIdResponse, Failure>) -> Void = { result in
                switch result {
                case .success(let profileIdRes):
                    Global.user.userId = profileIdRes.id
                case .failure(_):
                    break
                }
                continuation.resume(with: Result.success(Global.user.userId))
            }
            self.networkManager.request(request: request, callBack: resBlock)
        }
    }
}
