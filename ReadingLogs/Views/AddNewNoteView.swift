//
//  AddNewNoteView.swift
//  ReadingLogs
//
//  Created by Martin Wainaina on 04/02/2024.
//

import SwiftUI
import SwiftData

struct AddNewNoteView: View {
    
    let book: Book
    
    @State private var title = ""
    @State private var message = ""
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form{
            TextField("Note title", text: $title)
            TextField("Note", text: $message)
        }
        .navigationTitle("Add new title")
        .toolbar{
            
            // Close
            ToolbarItem(placement: .topBarLeading) {
                Button("Close"){
                    dismiss()
                }
            }
            
            // Save
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save"){
                    let note  = Note(title: title, message: message)
                    note.book = book
                    context.insert(note)
                    
                    do {
                        try context.save()
                        book.notes.append(note)
                    }
                    catch{
                        print("DEBUG: Failed to save note with error \(error.localizedDescription)")
                    }
                    
                    dismiss()
                }
            }
        }
    }
}

//#Preview {
//    AddNewNoteView()
//}
