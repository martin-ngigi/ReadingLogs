//
//  AddNewBookView.swift
//  ReadingLogs
//
//  Created by Martin Wainaina on 28/01/2024.
//

import SwiftUI
import SwiftData

struct AddNewBookView: View {
    
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var publishedYear: Int?
    
    //context will be used to access and save our records
    @Environment(\.modelContext) private var context
    
    // dismiss is used to dismiss view presented as a sheet
    @Environment(\.dismiss) private var dismiss
    
    private var isValid: Bool {
        !title.isEmpty && !author.isEmpty && publishedYear != nil
    }
    
    @State private var selectedGenres = Set<Genre>() // initialize with empty set
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading){
                // Title
                Text("Book title")
                TextField("Enter title", text: $title)
                    .textFieldStyle(.roundedBorder)
                
                // Author
                Text("Author")
                TextField("Enter book author", text: $author)
                    .textFieldStyle(.roundedBorder)
                
                // Year
                Text("Published year")
                TextField("Enter published year", value: $publishedYear, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                
                GenereSelectionView(selectedGenres: $selectedGenres)
                
                HStack{
                    Button("Cancel", role: .destructive){
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                    
                    Spacer()
                    
                    Button("Save") {
                        guard let publishedYear else { return }
                        let book = Book(title: title, author: author, publishedYear: publishedYear)
                        
                        ///save genre
                        book.genre = Array(selectedGenres)
                        selectedGenres.forEach { genre in
                            genre.books.append(book)
                            context.insert(genre)
                        }
                        
                        
                        context.insert(book)
                        
                        do {
                            try context.save()
                        }
                        catch {
                            print("DEBUG: Failed to save book with error \(error.localizedDescription)")
                        }
                        
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                    .disabled(!isValid)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Add New Book")
        }
    }
}

#Preview {
    AddNewBookView()
}
