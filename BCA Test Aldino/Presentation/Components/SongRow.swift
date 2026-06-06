//
//  SongRow.swift
//  BCA Test Aldino
//
//  Created by Aldino Efendi on 2026/06/06.
//

import SwiftUI

struct SongRow: View {
    
    let song: Song
    let isPlaying: Bool
    let playerStatus: PlayerStatus
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: song.artworkUrl100 ?? ""))
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(song.trackName)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(song.artistName)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            
            Spacer()
            
            if isPlaying {
                Image(systemName: "waveform")
                    .symbolEffect(
                        .bounce.up,
                        options: .repeating,
                        isActive: playerStatus.isPlaying)
            }
        }
    }
}
