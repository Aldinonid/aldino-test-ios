//
//  MiniPlayerView.swift
//  BCA Test Aldino
//
//  Created by Aldino Efendi on 2026/06/06.
//

import SwiftUI

struct MiniPlayerView: View {
    
    @ObservedObject var viewModel: PlayerViewModel
    let onExpand: () -> Void
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(.gray.opacity(0.2))
                    Rectangle()
                        .fill(.blue)
                        .frame(width: max(0, geometry.size.width * percentage))
                        .animation(.linear(duration: 0.1), value: percentage)
                }
            }
            .frame(height: 2)
            
            HStack(spacing: 12) {
                artwork
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.currentSong?.trackName ?? "-")
                        .font(.headline)
                        .lineLimit(1)
                    
                    Text(viewModel.currentSong?.artistName ?? "-")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
                Spacer()
                HStack(spacing: 12) {
                    Button {
                        viewModel.previous()
                    } label: {
                        Image(systemName: "backward.fill")
                            .font(.system(size: 20))
                    }
                    
                    Button {
                        viewModel.togglePlayPause()
                    } label: {
                        Image(
                            systemName:
                                viewModel.playbackState == .playing
                            ? "pause.fill"
                            : "play.fill"
                        )
                        .font(.system(size: 30))
                    }
                    
                    Button {
                        viewModel.next()
                    } label: {
                        Image(systemName: "forward.fill")
                            .font(.system(size: 20))
                    }
                }
            }
        }
        .padding(.horizontal)
        .frame(height: 70)
        .contentShape(Rectangle())
        .onTapGesture {
            onExpand()
        }
        
    }
    
    private var artwork: some View {
        AsyncImage(url: URL(string: viewModel.currentSong?.artworkUrl100 ?? "")) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            Color.gray.opacity(0.2)
        }
        .frame(width: 50, height: 50)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    private var percentage: Double {
        min(viewModel.progress / viewModel.duration, 1)
    }
}
