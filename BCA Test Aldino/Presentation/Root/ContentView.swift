//
//  ContentView.swift
//  BCA Test Aldino
//
//  Created by Aldino Efendi on 2026/06/06.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var searchViewModel = SearchViewModel(repository: MusicRepository())
    @StateObject private var playerViewModel = PlayerViewModel(playerManager: AudioPlayerManager())
    
    @State private var showPlayer = false
    
    var body: some View {
        VStack {
            SearchView(viewModel: searchViewModel,
                       playerViewModel: playerViewModel)
            
            if playerViewModel.currentSong != nil {
                Divider()
                MiniPlayerView(viewModel: playerViewModel) {
                    showPlayer = true
                }
            }
        }
        .navigationTitle("Music Player")
        .sheet(isPresented: $showPlayer) {
            PlayerView()
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    ContentView()
}
