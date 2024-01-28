//
//  ContentView.swift
//  ReadingLogs
//
//  Created by Martin Wainaina on 28/01/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var launcAddNew = false
    
    var body: some View {
        Button("Add new book"){
            launcAddNew.toggle()
        }
        .buttonStyle(.bordered)
        .sheet(isPresented: $launcAddNew, content: {
            AddNewBookView()
        })
    }
}

#Preview {
    ContentView()
}
