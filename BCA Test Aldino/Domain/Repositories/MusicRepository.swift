//
//  MusicRepository.swift
//  BCA Test Aldino
//
//  Created by Aldino Efendi on 2026/06/06.
//

import Foundation

protocol MusicRepositoryProtocol: Sendable {
    func searchSong(term: String) async throws -> [Song]
}

final class MusicRepository: MusicRepositoryProtocol {
    private let networkManager: NetworkManaging

    init(networkManager: NetworkManaging = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    func searchSong(term: String) async throws -> [Song] {
        let response: SearchResponse = try await networkManager.request(
            .search(term: term),
            type: SearchResponse.self
        )
        return response.results
    }
}
