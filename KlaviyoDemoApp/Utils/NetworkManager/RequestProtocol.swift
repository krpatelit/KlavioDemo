//
//  RequestProtocol.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/9/22.
//

import Foundation
/// SDKHttpApi: All Network request parameters can be abstracted by conforming to this protocol. It also conforms to CustomStringConvertible to print all parameter details. All parameters are only having
/// getters so the classes conforming will implement them with return value.
protocol RequestProtocol {
    /// path: Path which is appended to url for a specific network request
    var url: String { get }
    /// method: HTTPMethod is an alamofire abstraction for type of request. Ex - GET, PUT, POST
    var method: String { get }
    /// headers: HTTPHeaders is an alamofire abstraction to define the headers in key value pairs.
    var headers: [String: String]? { get }
    /// parameters: Parameters is an alamofire abstraction to define the headers in key value pairs. This are called the query parameters for request.
    var postBody: Data? { get }
}

extension RequestProtocol {

    var method: String {
        return "GET"
    }

    var headers: [String: String]? {
        return nil
    }

    var postBody: Data? {
        return nil
    }
}
