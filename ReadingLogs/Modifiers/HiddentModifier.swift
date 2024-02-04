//
//  HiddentModifier.swift
//  ReadingLogs
//
//  Created by Martin Wainaina on 04/02/2024.
//

import Foundation
import SwiftUI

struct HiddentModifier: ViewModifier {
    var isEnabled = false
    
    func body(content: Content) -> some View {
        if isEnabled {
            content.hidden()
        }
        else {
            content
        }
    }
}

extension View {
    func hidden(isEnabled: Bool) -> some View{
        modifier(HiddentModifier(isEnabled: isEnabled))
    }
}
