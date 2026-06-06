//
//  Endpoint.swift
//  BCA Test Aldino
//
//  Created by Aldino Efendi on 2026/06/06.
//

import Foundation

enum Endpoint {
    case search(term: String, limit: Int = 25)

    func makeURLRequest() throws -> URLRequest {
        guard let url = buildURL() else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        return request
    }

    private func buildURL() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host   = "itunes.apple.com"

        switch self {
        case .search(let term, let limit):
            components.path = "/search"
            components.queryItems = [
                URLQueryItem(name: "term",   value: term),
                URLQueryItem(name: "media",  value: "music"),
                URLQueryItem(name: "entity", value: "song"),
                URLQueryItem(name: "limit",  value: "\(limit)")
            ]
        }
        return components.url
    }
}
