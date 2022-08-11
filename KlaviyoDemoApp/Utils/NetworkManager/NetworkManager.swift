//
//  NetworkManager.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/9/22.
//

import Foundation

enum Failure: Error {
    case badUrl, badRespons, parsingError
}

class NetworkManager: Networking {

    private func decode<T: Decodable>(_ type: T.Type,data: Data) throws -> T? {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }

    func request<T: Decodable>(request: RequestProtocol, callBack: @escaping (Result<T, Failure>) -> Void) {

        guard let url = URL(string: request.url) else {
            DispatchQueue.main.async {
                callBack(.failure(.badUrl))
            }
            return
        }
        var urlRequest = URLRequest(url: url)
        if let header = request.headers {
            for (key, value) in header {
                urlRequest.setValue(value ,forHTTPHeaderField: key)
            }
        }

        urlRequest.httpMethod = request.method
        if let postData = request.postBody {
            urlRequest.httpBody = postData
        }
        print(request)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                callBack(.failure(.badRespons))
                return
            }
            print("\(String(describing: response))")
            let responseString = String(decoding: data, as: UTF8.self)
            print(responseString)
            if let model = try? self.decode(T.self, data: data) {
                //print("Log: Response data is \(model)")
                DispatchQueue.main.async {
                    callBack(.success(model))
                }
            } else {
                DispatchQueue.main.async {
                    callBack(.failure(.parsingError))
                }
            }
        }.resume()
    }

}
