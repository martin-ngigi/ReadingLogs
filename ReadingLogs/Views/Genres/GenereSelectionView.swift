//
//  GenereSelectionView.swift
//  ReadingLogs
//
//  Created by Martin Wainaina on 04/02/2024.
//

import SwiftUI
import SwiftData

struct GenereSelectionView: View {
    
    @Query(sort: \Genre.name) private var genres: [Genre]
    @Binding var selectedGenres: Set<Genre>

    var body: some View {
        List{
            Section("Literery Genres"){
                ForEach(genres){ genre in
                    HStack{
                        Text(genre.name)
                        
                        Spacer()
                        
                        Image(systemName: selectedGenres.contains(genre) ? "checkmark.circle.fill" : "circle.dashed")
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if !selectedGenres.contains(genre) {
                            selectedGenres.insert(genre)
                        }
                        else {
                            selectedGenres.remove(genre)
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

//#Preview {
//    GenereSelectionView()
//}
