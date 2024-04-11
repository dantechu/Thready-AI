//
//  ChatWidget.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 4/10/23.
//

import SwiftUI

struct MessageRow: Identifiable {
    
    let id = UUID()
    
    var isInteractingWithChatGPT: Bool
    
    let sendImage: String
    let sendText: String
    
    var responseImage: Image
    var responseImageUrl: String

    var responseText: String?
    
    var responseError: String?
    
}
