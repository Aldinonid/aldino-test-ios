//
//  SearchResponse.swift
//  BCA Test Aldino
//
//  Created by Aldino Efendi on 2026/06/06.
//

import Foundation

struct SearchResponse: Decodable, Sendable {
    let resultCount: Int
    let results: [Song]
}
