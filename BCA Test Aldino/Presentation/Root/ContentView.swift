//
//  ContentView.swift
//  BCA Test Aldino
//
//  Created by Aldino Efendi on 2026/06/06.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var searchViewModel = SearchViewModel(repository: MusicRepository())
    
    var body: some View {
        ZStack(alignment: .bottom) {
            NavigationStack {
                SearchView(viewModel: searchViewModel)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
