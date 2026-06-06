//
//  MockAudioPlayer.swift
//  BCA Test AldinoTests
//
//  Created by Aldino Efendi on 2026/06/07.
//

import Foundation
@testable import BCA_Test_Aldino

final class MockAudioPlayer: AudioPlayer {
    var duration: Double = 30
    var currentTime: Double = 0
    var isPlaying: Bool = false
    
    var onTimeChanged: ((Double) -> Void)?
    var onDurationChanged: ((Double) -> Void)?
    var onPlaybackStateChanged: ((Bool) -> Void)?
    var onPlaybackFinished: (() -> Void)?
    
    private(set) var playedURL: URL?
    private(set) var seekedTime: Double?
    
    private(set) var playCalled = false
    private(set) var pauseCalled = false
    private(set) var resumeCalled = false
    
    func play(url: URL) {
        playCalled = true
        playedURL = url
    }
    
    func pause() {
        pauseCalled = true
    }
    
    func resume() {
        resumeCalled = true
    }
    
    func seek(to seconds: Double) {
        seekedTime = seconds
    }
}
