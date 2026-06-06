//
//  MockSong.swift
//  BCA Test AldinoTests
//
//  Created by Aldino Efendi on 2026/06/07.
//

import Foundation
@testable import BCA_Test_Aldino

extension Song {
    static func stub(
        trackId: Int = 1,
        trackName: String = "Test Song",
        artistName: String = "Test Artist",
        artworkUrl100: String = "Test Album",
        previewUrl: String = "https://example.com/preview.mp3"
    ) -> Song {
        Song(trackId: trackId,
             trackName: trackName,
             artistName: artistName,
             artworkUrl100: artworkUrl100,
             previewUrl: previewUrl)
    }
}
