//
//  NetworkManager.swift
//  BCA Test Aldino
//
//  Created by Aldino Efendi on 2026/06/06.
//

import Foundation

protocol NetworkManaging {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

final class NetworkManager: NetworkManaging {
    
    private let session: URLSession = .shared

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        do {
            let (data, response) = try await session.data(from: endpoint.url)

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
