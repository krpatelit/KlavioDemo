//
//  Networking.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/9/22.
//

import Foundation

protocol Networking {
    func request<T: Decodable>(request: RequestProtocol, callBack: @escaping (Result<T, Failure>) -> Void)
}
