//
//  Genre.swift
//  ReadingLogs
//
//  Created by Martin Wainaina on 04/02/2024.
//

import Foundation
import SwiftData

@Model
final class Genre {
    var name: String
    var books: [Book] = [] // initialized book array
    
    init(name: String) {
        self.name = name
    }
}
