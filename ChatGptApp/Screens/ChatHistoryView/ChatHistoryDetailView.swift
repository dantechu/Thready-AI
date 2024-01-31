//
//  ChatHistoryDetailView.swift
//  Thready AI
//
//  Created by Ankush Dhawan on 30/01/24.
//

import SwiftUI

struct ChatHistoryDetailView: View {
    var chatList = [ChatHistory]()
    var body: some View {
        
        ZStack{
            Color.BGCOLOR
                .ignoresSafeArea()
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            
            
            VStack {
                chatListView
            }
            
        }
        .onAppear {
        }
        .onDisappear {
        }
    }
    
    
    var chatListView: some View {
        ScrollViewReader { proxy in
            
            VStack(spacing: 0) {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(chatList, id: \.self) { message in
                            ChatHistorywidget(message: message)
                        }

                    }
            
                }
                .background(Color.clear)
               
                
                
            }
            }
            
            
        }
        
}

struct ChatHistoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChatHistoryDetailView()
    }
}


