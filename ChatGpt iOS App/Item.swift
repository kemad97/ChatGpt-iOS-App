//
//  Item.swift
//  ChatGpt iOS App
//
//  Created by Kerolos on 08/07/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
