//
//  NotesListView.swift
//  ReadingLogs
//
//  Created by Martin Wainaina on 04/02/2024.
//

import SwiftUI

struct NotesListView: View {
    let book: Book
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        List{
            ForEach(book.notes) { note in
                VStack(alignment: .leading){
                    Text(note.title)
                        .bold()
                    
                    Text(note.message)
                }
            }
            .onDelete(perform: deleteNote(indexSet:))
        }
    }
    
    private func deleteNote(indexSet: IndexSet){
        indexSet.forEach{ index in
            let note = book.notes[index]
            context.delete(note)
            
            book.notes.remove(at: index)
            
            do {
                try context.save()
            }
            catch {
                print("DEBUG: Failed to delete note with error \(error.localizedDescription)")
            }
        }
    }
}

//#Preview {
//    NotesListView()
//}
