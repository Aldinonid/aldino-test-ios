//
//  SearchViewModel.swift
//  BCA Test Aldino
//
//  Created by Aldino Efendi on 2026/06/06.
//

import Foundation
import Combine

@MainActor
final class SearchViewModel: ObservableObject {
    
    @Published var searchText = ""
    @Published private(set) var songs: [Song] = []
    @Published private(set) var state: ViewState = .idle
    
    private var allSongs: [Song] = []
    private let repository: MusicRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: MusicRepositoryProtocol) {
        self.repository = repository
        bindSearch()
    }
}

extension SearchViewModel {
    
    func search() async {
        await search(keyword: searchText)
    }
    
    func search(keyword: String) async {
        let trimmedKeyword = keyword.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedKeyword.isEmpty else {
            songs = []
            state = .idle
            return
        }
        state = .loading
        do {
            let result = try await repository.searchSong(term: trimmedKeyword)
            allSongs = result
            songs = result
            state = .loaded
        } catch {
            songs = []
            state = .error(error.localizedDescription)
        }
    }
    
    func bindSearch() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] keyword in
                guard let self else { return }
                Task {
                    await self.search(keyword: keyword)
                }
            }
            .store(in: &cancellables)
    }
    
}
