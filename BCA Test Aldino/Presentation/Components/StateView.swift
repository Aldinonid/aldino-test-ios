//
//  StateView.swift
//  BCA Test Aldino
//
//  Created by Aldino Efendi on 2026/06/06.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 14) {
            ProgressView()
                .controlSize(.large)
            Text("Searching…")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct EmptyStateView: View {
    let icon: String
    let title: String
    let message: String

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 52))
                .foregroundStyle(Color(.systemGray4))

            Text(title)
                .font(.headline)
                .foregroundStyle(.secondary)

            Text(message)
                .font(.subheadline)
                .foregroundStyle(.tertiary)
                .multilineTextAlignment(.center)
        }
        .padding(32)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ErrorStateView: View {
    let message: String
    var onRetry: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 44))
                .foregroundStyle(.orange)

            Text(message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)

            if let onRetry {
                Button("Try Again", action: onRetry)
                    .buttonStyle(.bordered)
                    .controlSize(.regular)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

