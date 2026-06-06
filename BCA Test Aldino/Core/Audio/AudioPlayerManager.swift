//
//  AudioPlayerManager.swift
//  BCA Test Aldino
//
//  Created by Aldino Efendi on 2026/06/06.
//

import AVFoundation

protocol AudioPlayer: AnyObject {
    
    var onPlaybackStateChanged: ((Bool) -> Void)? { get set }
    
    func play(url: URL)
    func pause()
    func resume()
    func seek(to seconds: Double)
}

final class AudioPlayerManager: AudioPlayer {
    
    var onPlaybackStateChanged: ((Bool) -> Void)?
    
    private var avPlayer: AVPlayer?
    
    func play(url: URL) {
        let item = AVPlayerItem(url: url)
        avPlayer = AVPlayer(playerItem: item)
        avPlayer?.play()
        onPlaybackStateChanged?(true)
    }
    
    func pause() {
        avPlayer?.pause()
        onPlaybackStateChanged?(false)
    }
    
    func resume() {
        avPlayer?.play()
        onPlaybackStateChanged?(true)
    }
    
    func seek(to seconds: Double) {
        let time = CMTime(seconds: seconds, preferredTimescale: 600)
        avPlayer?.seek(to: time)
    }
    
}
