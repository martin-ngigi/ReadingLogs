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
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(genres) { genre in
                    Text(genre.name)
                }
            }
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
}

//#Preview {
//    GenreListView()
//}
