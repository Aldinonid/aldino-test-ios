//
//  PlayerStatus.swift
//  BCA Test Aldino
//
//  Created by Aldino Efendi on 2026/06/06.
//

import Foundation

enum PlayerStatus: Equatable {
    case playing
    case paused
    case finished

    var isPlaying: Bool {
        guard case .playing = self else { return false }
        return true
    }
}
