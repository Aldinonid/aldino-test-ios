//
//  ViewState.swift
//  BCA Test Aldino
//
//  Created by Aldino Efendi on 2026/06/06.
//

import Foundation

enum ViewState: Equatable {
    case idle
    case loading
    case loaded
    case empty
    case error(String)
}
