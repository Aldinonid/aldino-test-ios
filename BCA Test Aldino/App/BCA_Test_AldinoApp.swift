//
//  BCA_Test_AldinoApp.swift
//  BCA Test Aldino
//
//  Created by Aldino Efendi on 2026/06/06.
//

import SwiftUI

@main
struct BCA_Test_AldinoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView(
                    searchViewModel: AppDI.makeSearchViewModel(),
                    playerViewModel: AppDI.makePlayerViewModel()
                )
            }
        }
    }
}
