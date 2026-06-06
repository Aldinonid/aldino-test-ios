//
//  SearchViewModelTests.swift
//  BCA Test AldinoTests
//
//  Created by Aldino Efendi on 2026/06/06.
//

import XCTest
@testable import BCA_Test_Aldino

@MainActor
final class SearchViewModelTests: XCTestCase {

    private var vm: SearchViewModel!
    private var repo: MockMusicRepository!

    override func setUp() {
        super.setUp()
        repo = MockMusicRepository()
        vm = SearchViewModel(repository: repo)
    }

    override func tearDown() {
        repo = nil
        vm = nil
        super.tearDown()
    }
}

extension SearchViewModelTests {
    func test_search_withEmptyKeyword_setsIdleState() async {
        await vm.search(keyword: "   ")
        XCTAssertTrue(vm.songs.isEmpty)
        XCTAssertEqual(vm.state, .idle)
    }
    
    func test_search_success_updatesSongs() async {
        repo.searchResult = [
            .stub(trackId: 1),
            .stub(trackId: 2)
        ]
        
        await vm.search(keyword: "Taylor")
        XCTAssertEqual(vm.songs.count, 2)
        XCTAssertEqual(vm.state, .loaded)
    }
    
    func test_search_emptyResult_setsEmptyState() async {
        repo.searchResult = []
        await vm.search(keyword: "Taylor")
        
        XCTAssertEqual(vm.songs.count, 0)
        XCTAssertEqual(vm.state, .empty)
    }
    
    func test_search_error_setsErrorState() async {
        repo.searchError = MockError.failed
        
        await vm.search(keyword: "Taylor")
        
        XCTAssertTrue(vm.songs.isEmpty)
        
        guard case .error = vm.state
        else {
            XCTFail()
            return
        }
    }
    
    func test_searchPreview_returnsOnlyFiveSongs() async {
        repo.searchResult = (1...10)
            .map { .stub(trackId: $0) }
        
        await vm.search(keyword: "Taylor", isPreview: true)
        
        XCTAssertEqual(vm.songs.count, 5)
    }
    
    func test_searchFull_returnsAllSongs() async {
        repo.searchResult = (1...10)
            .map { .stub(trackId: $0) }
        
        await vm.search(keyword: "Taylor", isPreview: false)
        
        XCTAssertEqual(vm.songs.count, 10)
    }
    
    func test_search_trimsWhitespace() async {
        
        await vm.search(keyword: " Taylor Swift ")
        
        XCTAssertEqual(repo.receivedKeyword, "Taylor Swift")
    }
    
    func test_searchTextTriggersDebouncedSearch() async {
        repo.searchResult = [.stub()]

        vm.searchText = "Taylor"

        try? await Task.sleep(
            for: .milliseconds(600)
        )

        XCTAssertEqual(repo.receivedKeyword, "Taylor")

        XCTAssertEqual(vm.state, .loaded)
    }
}
