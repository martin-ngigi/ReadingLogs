//
//  AddNewGenreView.swift
//  ReadingLogs
//
//  Created by Martin Wainaina on 04/02/2024.
//

import SwiftUI
import SwiftData

struct AddNewGenreView: View {
    
    @State private var name: String = ""
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack{
                TextField("Add new genre", text: $name)
                    .textFieldStyle(.roundedBorder)
                
                HStack{
                    
                    // Save
                    Button("Save"){
                        let genre = Genre(name: name)
                        context.insert(genre)
                        
                        do {
                            try context.save()
                        }
                        catch{
                            print("DEBUG: Failed to save genre with error \(error.localizedDescription)")
                        }
                        
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Spacer()
                    
                    // Cancel
                    Button("Cancel"){
                        dismiss()
                    }
                    .buttonStyle(.bordered)

                }
                
                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle("Add new genre")
        }
    }
}

#Preview {
    AddNewGenreView()
}
