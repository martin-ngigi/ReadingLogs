//
//  BooksViewModel.swift
//  ReadingLogs
//
//  Created by Hummingbird on 09/07/2025.
//

import Foundation

import Foundation

//@Observable
class BooksViewModel: ObservableObject {
    //@ObservationIgnored
    private let dataSource: BooksDataSource

    var books: [Book] = []

    init(dataSource: BooksDataSource = .shared) {
        self.dataSource = dataSource
        self.books = dataSource.fetchBooks()
    }

    func addBook(book: Book) {
        dataSource.addBook(book)
        fetchBooks()
    }
    
    func fetchBooks() {
        books = dataSource.fetchBooks()
    }

    func removeBook(_ book: Book) {
        dataSource.removeBook(book)
        fetchBooks()
    }
}
