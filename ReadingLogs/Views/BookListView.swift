//
//  BookListView.swift
//  ReadingLogs
//
//  Created by Martin Wainaina on 28/01/2024.
//

import SwiftUI
import SwiftData

struct BookListView: View {
    
    @Environment(\.modelContext) private var context
    
    @Query private var books: [Book] // Empty book array
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books){ book in
                    BookCellView(book: book)
                }
                .onDelete(perform: delete(indexSet:))
            }
            .navigationTitle("Reading Logs")
            .navigationDestination(for: Book.self) { book in
                BookDetailView(book: book)
            }
        }
    }
    
    private func delete(indexSet: IndexSet){
        indexSet.forEach { index in
            let book = books[index]
            context.delete(book)
            
            do{
                try context.save()
            }
            catch{
                print("DEBUG: Failed to delete book with error \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    BookListView()
}
