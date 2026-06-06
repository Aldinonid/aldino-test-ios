//
//  AudioPlayerManager.swift
//  BCA Test Aldino
//
//  Created by Aldino Efendi on 2026/06/06.
//

import AVFoundation

protocol AudioPlayer: AnyObject {
    func play(url: URL)
    func pause()
    func resume()
    func seek(to seconds: Double)
}

final class AudioPlayerManager: AudioPlayer {
    
    private var avPlayer: AVPlayer?
    
    func play(url: URL) {
        let item = AVPlayerItem(url: url)
        avPlayer = AVPlayer(playerItem: item)
        avPlayer?.play()
    }
    
    func pause() {
        avPlayer?.pause()
    }
    
    func resume() {
        avPlayer?.play()
    }
    
    func seek(to seconds: Double) {
        let time = CMTime(seconds: seconds, preferredTimescale: 600)
        avPlayer?.seek(to: time)
    }
    
}
