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
            HStack(alignment: .top) {
                
                if let cover = book.cover, let image = UIImage(data: cover){
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(.rect(cornerRadius: 5))
                        .frame(height: 100)
                }
                VStack(alignment: .leading){
                    Text(book.title)
                        .bold()
                    
                    Group{
                        Text("**Author**: \(book.author)")
                                                
                        Text("**Pusblished on**: \(book.publishedYear.description)")
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }
            }
        }

    }
}

//#Preview {
//    BookCellView()
//}
