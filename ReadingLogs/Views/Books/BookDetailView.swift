//
//  BookDetailView.swift
//  ReadingLogs
//
//  Created by Martin Wainaina on 28/01/2024.
//

import SwiftUI
import PhotosUI

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
    
    @State private var selectedCover: PhotosPickerItem?
    @State private var selectedCoverData: Data?
        
    // initialize values
    init(book: Book){
        self.book = book
        self._title = State.init(initialValue: book.title)
        self._author = State.init(initialValue: book.author)
        self._publishedYear = State.init(initialValue: book.publishedYear)
        
        self._selectedGenres = State.init(initialValue: Set(book.genre))
    }
    
    private var bookCoverUI: some View {
        HStack{
            PhotosPicker(
                selection: $selectedCover,
                matching: .images,
                photoLibrary: .shared()
            ){
                
                Label(book.cover == nil ? "Add Cover" : "Update Cover", systemImage: "book.closed")
            }
            .padding()
            
            Spacer()
            
            if let selectedCoverData, let image = UIImage(data: selectedCoverData){
                
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 10))
                    .frame(width: 100, height: 100)
            }
            else if let cover = book.cover, let image = UIImage(data: cover){
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 10))
                    .frame(width: 100, height: 100)
            }
            else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }
        }
        
    }
    
    var body: some View {
        Form{
            if isEditing {
                Group {
                    TextField("Book title", text: $title)
                    TextField("Book author", text: $author)
                    TextField("Book published year", value: $publishedYear, format: .number.grouping(.never)) //.grouping(.never) removes the unwanted coma
                        .keyboardType(.numberPad)
                    
                    
                    // book cover
                    bookCoverUI
                    
                    // genre
                    GenereSelectionView(selectedGenres: $selectedGenres)
                        .frame(height: 300)
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
                    
                    // save book cover
                    if let selectedCoverData {
                        book.cover = selectedCoverData
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
                                
                // display image
                if let cover = book.cover, let image = UIImage(data: cover) {
                    HStack {
                        Text("Book Cover")
                        
                        Spacer()
                        
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerRadius: 10))
                            .frame(height: 100)
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
                        ContentUnavailableView("No notes", systemImage: "pencil.and.list.clipboard")
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
        .task(id: selectedCover) {
            // set selected image
            if let data = try? await selectedCover?.loadTransferable(type: Data.self){
                selectedCoverData = data
            }
        }
        .navigationTitle("Book Details")
    }
}

//#Preview {
//    BookDetailView()
//}
