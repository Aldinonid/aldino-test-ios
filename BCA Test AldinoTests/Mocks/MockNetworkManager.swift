//
//  MockNetworkManager.swift
//  BCA Test AldinoTests
//
//  Created by Aldino Efendi on 2026/06/07.
//

import Foundation
@testable import BCA_Test_Aldino

final class MockNetworkManager: NetworkManaging {

    var response: Any?
    var error: Error?

    private(set) var requestedEndpoint: Endpoint?

    func request<T>(_ endpoint: Endpoint) async throws -> T where T : Decodable {
        requestedEndpoint = endpoint
        if let error { throw error}
        return response as! T
    }
}
