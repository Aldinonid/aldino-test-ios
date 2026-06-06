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
                ContentUnavailableView("Search Music",
                                       systemImage: "music.note")
            case .loading:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .loaded:
                List(viewModel.songs) { song in
                    Button {
                        playerViewModel.setup(songs: viewModel.songs)
                        playerViewModel.play(song)
                    } label: {
                        Text(song.trackName)
                    }
                    .buttonStyle(.plain)
                }
            case .empty:
                ContentUnavailableView.search
            case .error(let message):
                ContentUnavailableView("Something Went Wrong",
                                       systemImage: "exclamationmark.triangle",
                                       description: Text(message))
            }
        }
        .searchable(text: $viewModel.searchText,
                    placement: SearchFieldPlacement.navigationBarDrawer,
                    prompt: "Search Music")
        .navigationBarTitleDisplayMode(.inline)
    }
}
