//
//  Request.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 25/05/2025.
//

import Foundation
import EnvironmentVariables
import Helpers

public protocol Request {
    var privateKey: String { get }
    var publicKey: String { get }
    var ts: String { get }
    var hash: String { get }
    var params: [String: String] { get }
    var endPoint: String { get }
    var request: URLRequest? { get }
}

public extension Request {
    var privateKey: String {
        Bundle.main.object(forInfoDictionaryKey: "PRIVATE_KEY") as? String ?? ""
    }
    var publicKey: String {
        Bundle.main.object(forInfoDictionaryKey: "PUBLIC_KEY") as? String ?? ""
    }
    var ts: String {
        return String(Int(Date().timeIntervalSince1970))
    }
    var hash: String {
        return "\(ts)\(privateKey)\(publicKey)".md5
    }
    var request: URLRequest? {
        let urlString = EnvironmentVariables.baseUrl.rawValue + EnvironmentVariables.version.rawValue + endPoint

        guard let url = URL(string: urlString) else { return nil }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let url = components?.url else { return nil }

        var request = URLRequest(url: url)
        request.setValue(EnvironmentVariables.accept.rawValue, forHTTPHeaderField: "accept")
        request.httpMethod = HTTPMethod.get.rawValue
        return request
    }
}
