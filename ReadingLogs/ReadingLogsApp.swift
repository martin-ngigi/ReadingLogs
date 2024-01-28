//
//  ReadingLogsApp.swift
//  ReadingLogs
//
//  Created by Martin Wainaina on 28/01/2024.
//

import SwiftUI
import SwiftData

@main
struct ReadingLogsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Book.self]) // import SwiftData
        }
    }
}
