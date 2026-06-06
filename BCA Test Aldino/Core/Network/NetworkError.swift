//
//  NetworkError.swift
//  BCA Test Aldino
//
//  Created by Aldino Efendi on 2026/06/06.
//

import Foundation

enum NetworkError: LocalizedError, Equatable {
    case invalidURL
    case invalidResponse
    case badStatusCode(Int)
    case noData
    case decodingFailed
    case noInternet
    case unknown(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The request URL is invalid."
        case .invalidResponse:
            return "Received an unexpected response from the server."
        case .badStatusCode(let code):
            return "Server returned an error (status \(code))."
        case .noData:
            return "No data was received from the server."
        case .decodingFailed:
            return "Failed to parse the server response."
        case .noInternet:
            return "No internet connection. Please check your network."
        case .unknown(let message):
            return "An unexpected error occurred: \(message)"
        }
    }

    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        lhs.errorDescription == rhs.errorDescription
    }
}
