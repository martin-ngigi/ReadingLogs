//
//  GenreListView.swift
//  ReadingLogs
//
//  Created by Martin Wainaina on 04/02/2024.
//

import SwiftUI
import SwiftData

struct GenreListView: View {
    
    // Help us define whether our record should be sorted in certain creteria
    @Query(sort: \Genre.name)
    private var genres: [Genre]
    
    @State private var presentAddNew = false
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(genres) { genre in
                    
                    // pass genre along from GenreListView to GenreDetailView
                    NavigationLink(value: genre) {
                        Text(genre.name)
                    }
                }
                .onDelete(perform: deleteGenre(indexSet:))
            }
            .navigationDestination(for: Genre.self, destination: { genre in
                GenreDetailsView(genre: genre)
            })
            .navigationTitle("Literery Genre")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        presentAddNew.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .buttonStyle(.borderedProminent)
                    .sheet(isPresented: $presentAddNew) {
                        AddNewGenreView()
                            .presentationDetents([.fraction(0.3)]) // cover only 30 %
                            .interactiveDismissDisabled() // present unwanted dismismiss
                    }
                }
            }
        }
    }
    
    private func deleteGenre(indexSet: IndexSet) {
        indexSet.forEach { index in
            let genreToDelete = genres[index]
            context.delete(genreToDelete)
            
            do{
                try context.save()
            }
            catch{
                print("DEBUG: Failed to delete genre with error \(error.localizedDescription)")
            }
        }
    }
}

//#Preview {
//    GenreListView()
//}
