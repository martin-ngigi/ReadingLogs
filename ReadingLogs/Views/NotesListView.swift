//
//  NotesListView.swift
//  ReadingLogs
//
//  Created by Martin Wainaina on 04/02/2024.
//

import SwiftUI

struct NotesListView: View {
    let book: Book
    
    
    var body: some View {
        List{
            ForEach(book.notes) { note in
                Text(note.title)
                    .bold()
                
                Text(note.message)
            }
        }
    }
}

//#Preview {
//    NotesListView()
//}
