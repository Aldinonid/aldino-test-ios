//
//  PlayerViewModel.swift
//  BCA Test Aldino
//
//  Created by Aldino Efendi on 2026/06/06.
//

import Foundation
import Combine

@MainActor
final class PlayerViewModel: ObservableObject {
    
    @Published var currentSong: Song?
    @Published var playbackState: PlayerStatus = .paused
    
    @Published var progress: Double = 0
    @Published var duration: Double = 0
    
    @Published var isSeeking = false
    
    private let playerManager: AudioPlayer
    private var songs: [Song] = []
    private(set) var currentIndex = 0
    
    init(playerManager: AudioPlayer) {
        self.playerManager = playerManager
        bindPlayer()
    }
    
    func setup(songs: [Song]) {
        self.songs = songs
    }
    
    func play(_ song: Song) {
        guard let index = songs.firstIndex(where: { $0.trackId == song.trackId }) else { return }
        playSong(at: index)
    }
    
    func playSong(at index: Int) {
        guard songs.indices.contains(index) else { return }
        currentIndex = index
        currentSong = songs[index]
        
        guard let previewUrl = currentSong?.previewUrl,
              let url = URL(string: previewUrl)
        else { return }
        playbackState = .playing
        playerManager.play(url: url)
    }
    
    func pause() {
        playerManager.pause()
    }
    
    func togglePlayPause() {
        switch playbackState {
        case .playing:
            playerManager.pause()
        case .paused:
            playerManager.resume()
        case .finished:
            progress = 0
            playerManager.seek(to: 0)
            playerManager.resume()
        }
    }
    
    func next() {
        let nextIndex = currentIndex + 1
        guard songs.indices.contains(nextIndex) else { return }
        playSong(at: nextIndex)
    }
    
    func previous() {
        let previousIndex = currentIndex - 1
        guard songs.indices.contains(previousIndex) else { return }
        playSong(at: previousIndex)
    }
    
    func seek() {
        playerManager.seek(to: progress)
        isSeeking = false
    }
    
}

private extension PlayerViewModel {
    
    func bindPlayer() {
        playerManager.onTimeChanged = { [weak self] time in
            guard let self else { return }
            Task { @MainActor in
                guard !self.isSeeking else { return }
                self.progress = time
            }
        }
        
        playerManager.onDurationChanged = { [weak self] duration in
            guard let self else { return }
            Task { @MainActor in
                self.duration = duration
            }
        }
        
        playerManager.onPlaybackStateChanged = { [weak self] isPlaying in
            guard let self else { return }
            Task { @MainActor in
                self.playbackState = isPlaying ? .playing : .paused
            }
        }
        
        playerManager.onPlaybackFinished = { [weak self] in
            guard let self else { return }
            Task { @MainActor in
                self.playbackState = .finished
                self.progress = self.duration
            }
        }
    }
}

extension PlayerViewModel {
    
    var currentTimeText: String {
        formatTime(progress)
    }
    
    var durationText: String {
        formatTime(duration)
    }
    
    func formatTime(_ seconds: Double) -> String {
        guard seconds.isFinite else { return "0:00" }
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        return String(
            format: "%d:%02d",
            minutes,
            seconds
        )
    }
}
