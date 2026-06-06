//
//  Song.swift
//  BCA Test Aldino
//
//  Created by Aldino Efendi on 2026/06/06.
//

import Foundation

struct Song: Identifiable, Decodable, Sendable {
    let trackId: Int
    let trackName: String
    let artistName: String
    let artworkUrl100: String?
    let previewUrl: String?

    var id: Int {
        trackId
    }
}
