//
//  GenreListView.swift
//  ReadingLogs
//
//  Created by Martin Wainaina on 04/02/2024.
//

import SwiftUI
import SwiftData

struct GenreListView: View {
    
    // Filter
    //Similar to : SELECT * FROM TableName WHERE ColumnName CONTAINS 'keywords'
//    @Query(
//        FetchDescriptor<Genre>(predicate: #Predicate {
//            $0.name.localizedStandardContains("Fiction")
//        }),
//         animation: .bouncy
//    )
    
    // Sort
    // Help us define whether our record should be sorted in certain creteria
    // @Query(sort: \Genre.name, order: .forward, animation: .bouncy)
    
    // Sort and Filter
//    @Query(
//        filter: #Predicate {
//            $0.name.localizedStandardContains("Fiction")
//        },
//        sort: \Genre.name,
//        order: .reverse,
//        animation: .bouncy
//    )
    
    
    @State private var presentAddNew = false
    @State private var sortOrder: GenreSortOrder = .forward
        
    var body: some View {
        NavigationStack{
            GenreListSubView(sortOrder: sortOrder)
            .navigationTitle("Literery Genre")
            .toolbar{
                
                // Add New Genre
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
                
                // Sort
                ToolbarItem(placement: .topBarLeading) {
                    Button{
                        sortOrder = sortOrder == GenreSortOrder.forward ? GenreSortOrder.reverse : GenreSortOrder.forward
                    } label: {
                        Image(systemName: sortOrder == GenreSortOrder.forward ?  "arrow.down" : "arrow.up")
                    }
                    .buttonStyle(.bordered)
                    
                }
            }
        }
    }
    

}

//#Preview {
//    GenreListView()
//}
