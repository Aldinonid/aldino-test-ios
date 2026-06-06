//
//  Endpoint.swift
//  BCA Test Aldino
//
//  Created by Aldino Efendi on 2026/06/06.
//

import Foundation

enum Endpoint {
    case search(term: String, limit: Int = 25)

    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"

        switch self {
        case let .search(term, limit):
            components.path = "/search"
            components.queryItems = [
                .init(name: "term", value: term),
                .init(name: "media", value: "music"),
                .init(name: "entity", value: "song"),
                .init(name: "limit", value: "\(limit)")
            ]
        }

        return components.url!
    }
}
