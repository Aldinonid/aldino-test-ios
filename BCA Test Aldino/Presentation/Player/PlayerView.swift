//
//  PlayerView.swift
//  BCA Test Aldino
//
//  Created by Aldino Efendi on 2026/06/06.
//

import SwiftUI

struct PlayerView: View {
    
    @ObservedObject var viewModel: PlayerViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            CachedAsyncImage(url: URL(string: viewModel.currentSong?.artworkUrl100 ?? ""))
                .frame(maxWidth: 300)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.top, 24)
            
            VStack(spacing: 8) {
                Text(viewModel.currentSong?.trackName ?? "-")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(viewModel.currentSong?.artistName ?? "-")
                    .foregroundStyle(.secondary)
            }
            
            VStack {
                Slider(
                    value: $viewModel.progress,
                    in: 0...max(viewModel.duration, 1),
                    onEditingChanged: { editing in
                        viewModel.isSeeking = editing
                        if !editing {
                            viewModel.seek()
                        }
                    }
                )
                
                HStack {
                    Text(viewModel.currentTimeText)
                    Spacer()
                    Text(viewModel.durationText)
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            
            HStack(spacing: 40) {
                Button {
                    viewModel.previous()
                } label: {
                    Image(systemName: "backward.fill")
                        .font(.largeTitle)
                }
                
                Button {
                    viewModel.togglePlayPause()
                } label: {
                    Image(
                        systemName:
                            viewModel.playbackState == .playing
                        ? "pause.circle.fill"
                        : "play.circle.fill"
                    )
                    .font(.system(size: 70))
                }
                
                Button {
                    viewModel.next()
                } label: {
                    Image(systemName: "forward.fill")
                        .font(.largeTitle)
                }
            }
        }
        .padding()
    }
}

