//
//  AppDI.swift
//  BCA Test Aldino
//
//  Created by Aldino Efendi on 2026/06/06.
//

import Foundation

enum AppDI {
    
    static func makeNetworkManager() -> NetworkManager {
        NetworkManager()
    }
    
    static func makeMusicRepository() -> MusicRepository {
        MusicRepository(networkManager: makeNetworkManager())
    }
    
    static func makeSearchViewModel() -> SearchViewModel {
        SearchViewModel(repository: makeMusicRepository())
    }
    
    static func makePlayerViewModel() -> PlayerViewModel {
        PlayerViewModel(playerManager: AudioPlayerManager())
    }
    
}
