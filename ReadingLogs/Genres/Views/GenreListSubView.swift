//
//  GenreListSubView.swift
//  ReadingLogs
//
//  Created by Martin Wainaina on 05/02/2024.
//

import SwiftUI
import SwiftData

struct GenreListSubView: View {
    
    @Query private var genres: [Genre]
    @Environment(\.modelContext) private var context
    
    init(sortOrder: GenreSortOrder = .forward){
        _genres = Query(FetchDescriptor<Genre>(sortBy: [sortOrder.sortOption]), animation: .snappy)
    }
    
    var body: some View {
        Group {
            if !genres.isEmpty {
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
            }
            else {
                ContentUnavailableView("Time to add new Genre", systemImage: "square.3.layers.3d.down.left")
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

#Preview {
    GenreListSubView()
}
