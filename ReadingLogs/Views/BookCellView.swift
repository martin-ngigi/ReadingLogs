//
//  BookCellView.swift
//  ReadingLogs
//
//  Created by Martin Wainaina on 28/01/2024.
//

import SwiftUI

struct BookCellView: View {
    let book: Book
    
    var body: some View {
        NavigationLink(value: book){
            VStack(alignment: .leading){
                Text(book.title)
                    .bold()
                
                HStack{
                    Text("**Author**: \(book.author)")
                    
                    Spacer()
                    
                    Text("**Pusblished on**: \(book.publishedYear.description)")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.top, 20)
            }
        }

    }
}

//#Preview {
//    BookCellView()
//}
