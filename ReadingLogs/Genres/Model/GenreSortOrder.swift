//
//  GenreSortOrder.swift
//  ReadingLogs
//
//  Created by Martin Wainaina on 05/02/2024.
//

import SwiftUI

enum GenreSortOrder: String, Identifiable, CaseIterable {
    case forward
    case reverse
    
    var id: Self { return self }
    
    var title: String {
        switch self {
        case .forward:
            return "Forward"
        case .reverse:
            return "Reverse"
        }
    }
    
    var sortOption: SortDescriptor<Genre> {
        switch self {
        case .forward:
            return SortDescriptor(\Genre.name, order: .forward)
        case .reverse:
            return SortDescriptor(\Genre.name, order: .reverse)
        }
    }
}
