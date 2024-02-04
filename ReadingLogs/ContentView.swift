//
//  ContentView.swift
//  ReadingLogs
//
//  Created by Martin Wainaina on 28/01/2024.
//

import SwiftUI

struct ContentView: View {
        
    var body: some View {
        TabView{
            BookListView()
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("Books")
                }
            
            GenreListView()
                .tabItem {
                    Image(systemName: "gear.circle.fill")
                    Text("Genre")
                }
        }
    }
}

#Preview {
    ContentView()
}
