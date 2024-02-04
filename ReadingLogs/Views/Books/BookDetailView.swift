//
//  BookDetailView.swift
//  ReadingLogs
//
//  Created by Martin Wainaina on 28/01/2024.
//

import SwiftUI

struct BookDetailView: View {
    
    let book: Book
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var isEditing = false
    
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var publishedYear: Int? = nil
    
    @State private var showAddNewNotes = false
    
    @State private var selectedGenres = Set<Genre>()
        
    // initialize values
    init(book: Book){
        self.book = book
        self._title = State.init(initialValue: book.title)
        self._author = State.init(initialValue: book.author)
        self._publishedYear = State.init(initialValue: book.publishedYear)
        
        self._selectedGenres = State.init(initialValue: Set(book.genre))
    }
    
    var body: some View {
        Form{
            if isEditing {
                Group {
                    TextField("Book title", text: $title)
                    TextField("Book author", text: $author)
                    TextField("Book published year", value: $publishedYear, format: .number.grouping(.never)) //.grouping(.never) removes the unwanted coma
                        .keyboardType(.numberPad)
                    
                    // genre
                    GenereSelectionView(selectedGenres: $selectedGenres)
                        .frame(height: 300)
                    Text("After editing/adding, click save button")
                }
                .textFieldStyle(.roundedBorder)
                
                Button("Save"){
                    guard let publishedYear = publishedYear else { return }
                    book.title = title
                    book.author = author
                    book.publishedYear = publishedYear
                    
                    // genre
                    book.genre = []
                    book.genre = Array(selectedGenres)
                    selectedGenres.forEach { genre in
                        if !genre.books.contains(where: { b in
                            b.title == book.title
                        }) {
                            genre.books.append(book)
                        }
                    }
                    
                    do {
                        try context.save()
                    }
                    catch{
                        print("DEBUG: Failed to update book with error \(error.localizedDescription)")
                    }
                    
                    dismiss()
                    
                }
                .buttonStyle(.bordered)
            }
            else{
                Text(book.title)
                Text(book.author)
                Text(book.publishedYear.description)
                
                // show selected genres
                // show only there is genere inserted
                if !book.genre.isEmpty {
                    HStack{
                        ForEach(book.genre) { genre in
                            Text(genre.name)
                                .font(.caption)
                                .padding(.horizontal)
                                .background(.green.opacity(0.3), in: .capsule)
                        }
                    }
                }
            }
            
            // Show notes when we are not editing
            if !isEditing {
                Section("Notes"){
                    Button("Add new note"){
                        showAddNewNotes.toggle()
                    }
                    .sheet(isPresented: $showAddNewNotes) {
                        NavigationStack{
                            AddNewNoteView(book: book)
                        }
                        .presentationDetents([.fraction(0.3)]) // 30% of the view
                        .interactiveDismissDisabled() // prevent user from dismissing the the View by swipping down or pressing outside the sheet
                    }
                    
                    if book.notes.isEmpty {
                        ContentUnavailableView("No notes", image: "notes")
                    }
                    else{
                        NotesListView(book: book)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button( isEditing ? "Done" :
                "Edit"){
                    isEditing.toggle()
                }
                .hidden(isEnabled: isEditing) // Check Modifiers folder
            }
        }
        .navigationTitle("Book Details")
    }
}

//#Preview {
//    BookDetailView()
//}
