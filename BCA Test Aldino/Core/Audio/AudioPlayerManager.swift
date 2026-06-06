//
//  AudioPlayerManager.swift
//  BCA Test Aldino
//
//  Created by Aldino Efendi on 2026/06/06.
//

import AVFoundation

protocol AudioPlayer: AnyObject {
    var duration: Double { get }
    var currentTime: Double { get }
    var isPlaying: Bool { get }
    
    var onTimeChanged: ((Double) -> Void)? { get set }
    var onDurationChanged: ((Double) -> Void)? { get set }
    var onPlaybackStateChanged: ((Bool) -> Void)? { get set }
    var onPlaybackFinished: (() -> Void)? { get set }
    
    func play(url: URL)
    func pause()
    func resume()
    func seek(to seconds: Double)
}

final class AudioPlayerManager: AudioPlayer {
    var onTimeChanged: ((Double) -> Void)?
    var onDurationChanged: ((Double) -> Void)?
    var onPlaybackStateChanged: ((Bool) -> Void)?
    var onPlaybackFinished: (() -> Void)?
    
    private var avPlayer: AVPlayer?
    private var timeObserver: Any?
    private var statusObserver: NSKeyValueObservation?
    
    init() {}
    
    deinit {
        removeTimeObserver()
        statusObserver?.invalidate()
    }
    
    var duration: Double {
        avPlayer?
            .currentItem?
            .duration
            .seconds ?? 0
    }
    
    var currentTime: Double {
        avPlayer?
            .currentTime()
            .seconds ?? 0
    }
    
    var isPlaying: Bool {
        avPlayer?.rate != 0
    }
    
    func play(url: URL) {
        removeTimeObserver()
        let item = AVPlayerItem(url: url)
        avPlayer = AVPlayer(playerItem: item)
        observeDuration()
        observeCurrentTime()
        avPlayer?.play()
        onPlaybackStateChanged?(true)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playerDidFinish),
            name: .AVPlayerItemDidPlayToEndTime,
            object: item
        )
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

private extension AudioPlayerManager {
    
    func observeDuration() {
        statusObserver = avPlayer?
            .currentItem?
            .observe(
                \.status,
                options: [.new]
            ) { [weak self] item, _ in
                guard let self,
                      item.status == .readyToPlay
                else { return }
                let duration = item.duration.seconds
                guard duration.isFinite else { return }
                self.onDurationChanged?(duration)
            }
    }
    
    func observeCurrentTime() {
        let interval = CMTime(seconds: 0.5, preferredTimescale: 600)
        timeObserver = avPlayer?
            .addPeriodicTimeObserver(
                forInterval: interval,
                queue: .main
            ) { [weak self] time in
                guard let self else { return }
                self.onTimeChanged?(time.seconds)
            }
    }
    
    func removeTimeObserver() {
        guard let timeObserver else { return }
        avPlayer?.removeTimeObserver(timeObserver)
        self.timeObserver = nil
    }
    
    @objc
    func playerDidFinish() {
        onPlaybackFinished?()
    }
    
}
