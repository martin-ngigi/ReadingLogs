//
//  Note.swift
//  ReadingLogs
//
//  Created by Martin Wainaina on 04/02/2024.
//

import Foundation
import SwiftData

@Model
final class Note{
    var title: String
    var message: String
    var book: Book? // book can be null
    
    init(title: String, message: String, book: Book? = nil) {
        self.title = title
        self.message = message
        self.book = book
    }
}
