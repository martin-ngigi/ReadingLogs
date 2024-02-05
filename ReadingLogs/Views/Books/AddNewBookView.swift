//
//  AddNewBookView.swift
//  ReadingLogs
//
//  Created by Martin Wainaina on 28/01/2024.
//

import SwiftUI
import SwiftData
import PhotosUI

struct AddNewBookView: View {
    
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var publishedYear: Int?
    
    
    @State private var selectedCover: PhotosPickerItem?
    @State private var selectedCoverData: Data?
    
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
                
                // Cover  Image
                HStack{
                    PhotosPicker( selection: $selectedCover, matching: .images, photoLibrary: .shared()){
                        
                        Label("Add Cover", systemImage: "book.closed")
                    }
                    .padding()
                    
                    Spacer()
                    
                    if let selectedCoverData,
                       let image = UIImage(data: selectedCoverData){
                                                
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
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
                
                // Year
                Text("Published year")
                TextField("Enter published year", value: $publishedYear, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                
                // Genre
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
            .task(id: selectedCover) {
                // set selected image
                if let data = try? await selectedCover?.loadTransferable(type: Data.self){
                    selectedCoverData = data
                }
            }
        }
    }
}

#Preview {
    AddNewBookView()
}
