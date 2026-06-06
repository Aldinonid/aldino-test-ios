//
//  ContentView.swift
//  BCA Test Aldino
//
//  Created by Aldino Efendi on 2026/06/06.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var searchViewModel: SearchViewModel
    @StateObject private var playerViewModel: PlayerViewModel
    
    @State private var showPlayer = false
    
    init(searchViewModel: SearchViewModel, playerViewModel: PlayerViewModel) {
        _searchViewModel = StateObject(wrappedValue: searchViewModel)
        _playerViewModel = StateObject(wrappedValue: playerViewModel)
    }
    
    var body: some View {
        VStack {
            SearchView(viewModel: searchViewModel,
                       playerViewModel: playerViewModel)
            
            if playerViewModel.currentSong != nil {
                MiniPlayerView(viewModel: playerViewModel) {
                    showPlayer = true
                }
            }
        }
        .navigationTitle("Music Player")
        .sheet(isPresented: $showPlayer) {
            PlayerView(viewModel: playerViewModel)
                .presentationDragIndicator(.visible)
        }
    }
}
