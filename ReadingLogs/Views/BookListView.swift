//
//  BookListView.swift
//  ReadingLogs
//
//  Created by Martin Wainaina on 28/01/2024.
//

import SwiftUI
import SwiftData

struct BookListView: View {
    
    @Query private var books: [Book] // Empty book array
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books){ book in
                    BookCellView(book: book)
                }
            }
            .navigationTitle("Reading Logs")
        }
    }
}

#Preview {
    BookListView()
}
