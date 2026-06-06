//
//  SearchView.swift
//  BCA Test Aldino
//
//  Created by Aldino Efendi on 2026/06/06.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var viewModel: SearchViewModel
    @ObservedObject var playerViewModel: PlayerViewModel
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .idle:
                emptyView
            case .loading:
                LoadingView()
            case .loaded:
                songList
            case .empty:
                noResult
            case .error(let message):
                errorView(message)
            }
        }
        .searchable(text: $viewModel.searchText,
                    placement: SearchFieldPlacement.navigationBarDrawer,
                    prompt: "Search Music")
        .onSubmit(of: .search) {
            Task {
                await viewModel.search()
            }
        }
    }
}

extension SearchView {
    
    var songList: some View {
        List(viewModel.songs) { song in
            Button {
                playerViewModel.setup(songs: viewModel.songs)
                playerViewModel.play(song)
            } label: {
                SongRow(song: song,
                        isPlaying: playerViewModel.currentSong?.trackId == song.trackId,
                        playerStatus: playerViewModel.playbackState)
            }
            .buttonStyle(.plain)
        }
    }
    
    var emptyView: some View {
        EmptyStateView(icon: "music.note.list",
                       title: "Search for music",
                       message: "Type an artist or song name above")
    }
    
    var noResult: some View {
        ContentUnavailableView("No Results",
                               systemImage: "magnifyingglass",
                               description: Text("Try searching for another song"))
    }
    
    func errorView(_ message: String) -> some View {
        ContentUnavailableView("Something Went Wrong",
                               systemImage: "exclamationmark.triangle",
                               description: Text(message))
    }
}
