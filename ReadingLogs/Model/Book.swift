//
//  Book.swift
//  ReadingLogs
//
//  Created by Martin Wainaina on 28/01/2024.
//

import Foundation
import SwiftData

//final since we wont be extending Book
@Model // converts swift data class into stored model that is managed by Swift data. We wont need other tools to manage the model
final class Book {
    var title: String
    var author: String
    var publishedYear: Int
    
    // image is not stored in the swift data for efficiency purposes
    // only a reference of the image is store in the databse
    @Attribute(.externalStorage)
    var cover: Data?
    
    // .cascade: Whenever this Book is Deleted, Delete Note as well
    // inverse referenceses the Note
    // This is a oneToMany relationship
    @Relationship( deleteRule: .cascade, inverse: \Note.book)
    var notes = [Note]() // initialize empty array of notes
    
    // .nullify: When book is deleted, the Genre shoul not be deleted. This is because there could be other books that use that genre name
    // This is a manyToMany relationship
    @Relationship(deleteRule: .nullify, inverse: \Genre.books)
    var genre = [Genre]()
    
    
    // initilaizer.
    init(title: String, author: String, publishedYear: Int) {
        self.title = title
        self.author = author
        self.publishedYear = publishedYear
    }
}
