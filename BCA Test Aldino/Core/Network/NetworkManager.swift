//
//  NetworkManager.swift
//  BCA Test Aldino
//
//  Created by Aldino Efendi on 2026/06/06.
//

import Foundation

protocol NetworkManaging {
    func request<T: Decodable>(_ endpoint: Endpoint, type: T.Type) async throws -> T
}

final class NetworkManager: NetworkManaging {
    static let shared = NetworkManager()
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func request<T: Decodable>(_ endpoint: Endpoint, type: T.Type) async throws -> T {
        do {
            let urlRequest = try endpoint.makeURLRequest()
            let (data, response) = try await session.data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.badStatusCode(httpResponse.statusCode)
            }
            guard !data.isEmpty else {
                throw NetworkError.noData
            }

            return try JSONDecoder().decode(T.self, from: data)

        } catch let error as NetworkError {
            throw error
        } catch let urlError as URLError where urlError.code == .notConnectedToInternet {
            throw NetworkError.noInternet
        } catch is DecodingError {
            throw NetworkError.decodingFailed
        } catch {
            throw NetworkError.unknown(error.localizedDescription)
        }
    }
}
