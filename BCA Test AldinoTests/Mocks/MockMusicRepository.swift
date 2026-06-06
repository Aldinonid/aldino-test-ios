//
//  MockMusicRepository.swift
//  BCA Test AldinoTests
//
//  Created by Aldino Efendi on 2026/06/07.
//

import Foundation
@testable import BCA_Test_Aldino

final class MockMusicRepository: MusicRepositoryProtocol {
    var searchResult: [Song] = []
    var searchError: Error?
    private(set) var receivedKeyword: String?
    
    func searchSong(term: String) async throws -> [Song] {
        receivedKeyword = term
        if let searchError { throw searchError }
        return searchResult
    }
}
