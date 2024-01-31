//
//  ChatHistoryDateVIewModel.swift
//  Thready AI
//
//  Created by Ankush Dhawan on 31/01/24.
//

import SwiftUI
class ChatHistoryDateVIewModel: ObservableObject {
    @Published var chatDates = [String:[ChatHistory]]()

    func filterArray(dateHistory:FetchedResults<ChatHistory>) {
        dateHistory.forEach { history in
            var dateStr = formatDate(history.chatDate ?? Date())
            if chatDates[dateStr] != nil {
                var array = chatDates[dateStr]
                array?.append(history)
                chatDates[dateStr] = array
            }else {
                chatDates[dateStr] = [history]
            }
        }
        print(chatDates)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

