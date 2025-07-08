//
//  ChatMessage.swift
//  ChatGpt iOS App
//
//  Created by Kerolos on 08/07/2025.
//

import Foundation

struct ChatMessage: Identifiable {
    let id = UUID()
    let isUser : Bool
    let content : String
    
}
