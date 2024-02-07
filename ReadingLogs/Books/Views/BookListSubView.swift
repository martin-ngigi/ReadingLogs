//
//  BookListSubView.swift
//  ReadingLogs
//
//  Created by Martin Wainaina on 06/02/2024.
//

import SwiftUI
import SwiftData

struct BookListSubView: View {
    
    @Environment(\.modelContext) private var context
    @Query private var books: [Book] // Empty book array
    
    var searchTerm: String
    
    init(searchTerm: String = "", bookSortOption: SortingOption = .none){
        self.searchTerm = searchTerm
        if searchTerm.isEmpty {
            _books = Query(sort: [bookSortOption.sortOption]) // if searchTerm is empty, initialize books with empty Query
        }
        else{
            _books = Query(
                filter: #Predicate{
                    $0.title.localizedStandardContains(searchTerm)
                },
                sort: [bookSortOption.sortOption]
            )
        }
    }
    
    
    var body: some View {
        Group {
            if !books.isEmpty {
                List {
                    ForEach(books){ book in
                        BookCellView(book: book)
                    }
                    .onDelete(perform: delete(indexSet:))
                }
            }
            else if searchTerm.isEmpty {
                ContentUnavailableView("No Books Yet, Start by adding one", systemImage: "square.stack.3d.up.fill" )
            }
            else {
                ContentUnavailableView.search(text: searchTerm)
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

//#Preview {
//    BookListSubView()
//}
