//
//  PlayerViewModelTests.swift
//  BCA Test AldinoTests
//
//  Created by Aldino Efendi on 2026/06/06.
//

import XCTest
@testable import BCA_Test_Aldino

@MainActor
final class PlayerViewModelTests: XCTestCase {
    private var vm: PlayerViewModel!
    private var playerManager: MockAudioPlayer!

    override func setUp() {
        super.setUp()
        playerManager = MockAudioPlayer()
        vm = PlayerViewModel(playerManager: playerManager)
    }

    override func tearDown() {
        vm = nil
        super.tearDown()
    }
}

extension PlayerViewModelTests {
    func test_playSong_updatesCurrentSong() {
        let mockSong: Song = .stub()
        vm.setup(songs: [mockSong])
        
        vm.play(mockSong)
        
        XCTAssertEqual(vm.currentSong?.trackId, 1)
        XCTAssertTrue(playerManager.playCalled)
        XCTAssertEqual(vm.playbackState, .playing)
    }
    
    func test_next_movesToNextSong() {
        let mockSongs: [Song] = [.stub(trackId: 1), .stub(trackId: 2)]
        vm.setup(songs: mockSongs)
        vm.play(mockSongs[1])
        vm.next()
        XCTAssertEqual(vm.currentSong?.trackId, 2)
    }
    
    func test_previous_restartsCurrentSong_whenProgressGreaterThanThree() {
        vm.progress = 10
        vm.previous()
        XCTAssertEqual(vm.progress, 0)
        XCTAssertEqual(playerManager.seekedTime, 0)
    }
    
    func test_togglePlayPause_pausesWhenPlaying() {
        vm.playbackState = .playing
        vm.togglePlayPause()
        XCTAssertTrue(playerManager.pauseCalled)
    }
    
    func test_togglePlayPause_resumesWhenPaused() {
        vm.playbackState = .paused
        vm.togglePlayPause()
        XCTAssertTrue(playerManager.resumeCalled)
    }
    
    func test_togglePlayPause_fromFinished_restartsSong() {
        vm.playbackState = .finished
        vm.progress = 25
        vm.togglePlayPause()
        XCTAssertEqual(vm.progress, 0)
        XCTAssertEqual(playerManager.seekedTime, 0)
        XCTAssertTrue(playerManager.resumeCalled)
    }
    
    func test_seek_movesPlayerToProgressPosition() {
        vm.progress = 15
        vm.seek()
        XCTAssertEqual(playerManager.seekedTime, 15)
    }
    
    func test_onTimeChanged_updatesProgress() async {
        playerManager.onTimeChanged?(12)
        await Task.yield()
        XCTAssertEqual(vm.progress, 12)
    }
    
    func test_onDurationChanged_updatesDuration() async {
        playerManager.onDurationChanged?(30)
        await Task.yield()
        XCTAssertEqual(vm.duration, 30)
    }
    
    func test_onPlaybackFinished_updatesState() async {
        vm.duration = 30
        playerManager.onPlaybackFinished?()
        await Task.yield()
        XCTAssertEqual(vm.playbackState, .finished)
        XCTAssertEqual(vm.progress, 30)
    }
}
