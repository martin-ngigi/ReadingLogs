//
//  GenreDetailsView.swift
//  ReadingLogs
//
//  Created by Martin Wainaina on 04/02/2024.
//

import SwiftUI
import SwiftData

struct GenreDetailsView: View {
    
    let genre: Genre
    
    var body: some View {
        VStack{
            Group{
                if genre.books.isEmpty {
                    ContentUnavailableView("No Books under this genre", systemImage: "square.stack.3d.up.slash")
                }
                else{
                    List(genre.books) { book in
                        Text(book.title)
                    }
                }
            }
        }
    }
}

//#Preview {
//    GenreDetailsView()
//}
