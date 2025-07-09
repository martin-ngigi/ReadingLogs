//
//  BooksDataSource.swift
//  ReadingLogs
//
//  Created by Hummingbird on 09/07/2025.
//

import Foundation
import SwiftData

final class BooksDataSource {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = BooksDataSource()

    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: Book.self)
        self.modelContext = modelContainer.mainContext
    }

    func addBook(_ book: Book) {
        modelContext.insert(book)
        do {
            try modelContext.save()
        } catch {
            fatalError("Failed to save Book: \(error.localizedDescription)")
        }
    }

    func fetchBooks() -> [Book] {
        do {
            return try modelContext.fetch(FetchDescriptor<Book>())
        } catch {
            fatalError("Failed to fetch Book: \(error.localizedDescription)")
        }
    }

    func removeBook(_ book: Book) {
        modelContext.delete(book)
        do {
            try modelContext.save()
        } catch {
            fatalError("Failed to delete Book: \(error.localizedDescription)")
        }
    }
}
