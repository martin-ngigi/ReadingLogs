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
    
    // initilaizer.
    init(title: String, author: String, publishedYear: Int) {
        self.title = title
        self.author = author
        self.publishedYear = publishedYear
    }
}
