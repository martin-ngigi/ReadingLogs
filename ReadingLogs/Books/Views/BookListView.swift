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
    
    @State private var presentAddNew = false
    
    @State private var searchTerm = ""
    
//    var filteredBooks: [Book] {
//        // if searchItem is empty, return initial books list
//        guard searchTerm.isEmpty == false else { return books}
//        
//        // else return searched books
//        return books.filter {
//            $0.title.localizedCaseInsensitiveContains(searchTerm)
//        }
//    }
    
    var body: some View {
        NavigationStack {
//            List {
//                ForEach(filteredBooks){ book in
//                    BookCellView(book: book)
//                }
//                .onDelete(perform: delete(indexSet:))
//            }
            BookListSubView(searchTerm: searchTerm)
            .searchable(
                text: $searchTerm,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search book title"
            )
            .navigationTitle("Reading Logs")
            .navigationDestination(for: Book.self) { book in
                BookDetailView(book: book)
            }
            .toolbar{
                
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button{
                        presentAddNew.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .buttonStyle(.borderedProminent)
                    .sheet(isPresented: $presentAddNew, content: {
                        AddNewBookView()
                    })
                }
            }
        }
    }
    
//    private func delete(indexSet: IndexSet){
//        indexSet.forEach { index in
//            let book = books[index]
//            context.delete(book)
//            
//            do{
//                try context.save()
//            }
//            catch{
//                print("DEBUG: Failed to delete book with error \(error.localizedDescription)")
//            }
//        }
//    }
}

#Preview {
    BookListView()
}
